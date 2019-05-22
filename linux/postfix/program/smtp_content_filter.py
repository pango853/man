#!/usr/bin/env python

# coding: utf8
import warnings
warnings.filterwarnings('ignore', category=DeprecationWarning)
from twisted.mail import smtp
from twisted.internet import protocol, reactor, defer
from zope.interface import implements
import datetime


class FilterMessage:
  implements(smtp.IMessage)
  
  def __init__(self, user):
    self.message = []
    self.user = user

  def lineReceived(self, line):
    self.message.append(line)

  def eomReceived(self):
    print "EOM, mail for %s" % self.user
    print "-----body-----"
    print "\n".join(self.message)
    print "-----body end-----"

    m = smtp.sendmail('localhost', str(self.user.orig), str(self.user), "\n".join(self.message), port=10026)
    print m
    return defer.succeed(None)

  def connectionLost(self):
    print "ConLost"


class FilterDelivery:
  implements(smtp.IMessageDelivery)

  def receivedHeader(self, helo, origin, recipients):
    rcvd = "Received: by localhost(content_filter) with SMTP"
    if len(recipients) == 1:
      rcvd += "\n        "
      rcvd += "for <%s>" % str(recipients[0])
    rcvd += ";\n        "
    rcvd += datetime.datetime.utcnow().strftime('%a, %d %b %Y %T +0000 (UTC)')
    return rcvd

  def validateFrom(self, helo, origin):
    return origin

  def validateTo(self, user):
    return lambda: FilterMessage(user)


class FilterSMTPFactory(smtp.SMTPFactory):
  def __init__(self, *a, **kw):
    smtp.SMTPFactory.__init__(self, *a, **kw)
    self.delivery = FilterDelivery()

  def buildProtocol(self, addr):
    p = smtp.SMTPFactory.buildProtocol(self, addr)
    p.delivery = self.delivery
    return p


if __name__ == '__main__':
  reactor.listenTCP(10025, FilterSMTPFactory())
  reactor.run()

