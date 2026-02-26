Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB512D8793
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772126972; cv=none; b=KLUONTLoxJwPw2kqm7vrI80V/rJ0JA6U8rUqZABurSvcWkUir47VgZFxiM6Ot7halRlg90DVtPgwqbihPZ9b47+3Ld/pUtUQsCnPwY4yaGLlHIU/zO547jxoq50puy2u3Ie7h0Pr3L1XADlD72R3n+fCEO+ABKd6QMbThTF5KP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772126972; c=relaxed/simple;
	bh=HkxuC+nx5cv8FxXXEPLtI1CKkJ3zA90jA9K1ZWlwOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXDswBa82LakhgDSYNoX8Q103rb6MGmLOfCvt/o530u2ANpaTc5GbtTl7qximLJj9uYLT1DjAF0GaSR/SXQYNdHRMjQn7Lx3QqRtt6X1Mj6cOm01rOaB3Pv2ttruzewWeuN3ganPVAVqI/n6eLmOFHJRfxpFFylKnErfcJ2zXlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fK89xSBs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WA/aXwMW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fK89xSBs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WA/aXwMW"
Date: Thu, 26 Feb 2026 18:29:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772126968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZTmXT8OEklMRMPnRi3PdFdSswJgDgsHV6ZxsOoaP1E=;
	b=fK89xSBsTi60oKmtmmfNaHfMjleb9Gh6tOJs86QmGDM3Zvhdx8dc1q1KsY9zAdkUxkuRr5
	OSHPrbUK7GBT17DocolsVYZnNKJbKf2JuqSl7qDMv5NmCkzK8P5ErlmwkUqJj6yFUcgiQw
	elufs0ke1ANFGROQKV/nDVM/XJijuhsRovxQRKz3f6HTBj0w2g+SNUxNrTQWYJtHIOg87W
	7mpuMKQX2uBQAg3/nmsqhYdBW7MOigo68oO/liKy0tsD+EFwf/2nzu4QSPdTVi63xfqXFr
	LB6P+DocJAm1CXY9eucKFtR+nVwxsi2+DzufBar8tJzQx6+EVRZIpBxTMSuoaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772126968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DZTmXT8OEklMRMPnRi3PdFdSswJgDgsHV6ZxsOoaP1E=;
	b=WA/aXwMW3Yua3PWz0tPGHqZ0MYmeQczx8RsPdjIEXnwNex9hxEKvnLSPrzWmcUghNydmmG
	2BH3V6FnzKOk2+AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260226172927.2Ck9wZMw@linutronix.de>
References: <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
 <20260217071952.WCXLGs5-@linutronix.de>
 <80114792206dc00d0099f00999a209e717debb12.camel@web.de>
 <20260217095700.SjYjM8RO@linutronix.de>
 <4fba57892e5bd6a1afc4a36a80b40e3ecc28cac5.camel@web.de>
 <fd609cfe186ee48e0e9a08e35764175a2516dd14.camel@web.de>
 <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de>
 <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de>

On 2026-02-18 13:50:14 [+0100], Bert Karwatzki wrote:
> Am Mittwoch, dem 18.02.2026 um 08:30 +0100 schrieb Sebastian Andrzej Siewior:
> > On 2026-02-17 20:10:09 [+0100], Bert Karwatzki wrote:
> > > 
> > > I tried to research the original commit which introduced the xmit_lock_owner check, but
> > > it is present since linux 2.3.6 (released 19990610) (when __dev_queue_xmit() was still called dev_queue_xmit()),
> > > so I can't tell the original idea behind that check (perhaps recuesion detection ...), so I'm
> > > not completely sure if it can be omitted (and just let dev_xmit_recursion() do the recursion checking).
> > 
> > Okay. Thank you. I add it to my list.
> > 
> I've thought about it again and I now think the xmit_lock_owner check IS necessary to
> avoid deadlocks on recursion in the non-RT case.
> 
> My idea to use get_current()->tgid as lock owner also does not work as interrupts are still enabled
> and __dev_queue_xmit() can be called from interrupt context. So in a situation where an interrupt occurs
> after the lock has been taken and the interrupt handler calls __dev_queue_xmit() on the same CPU a deadlock
> would occur.

The warning happens because taskA on cpuX goes through
HARD_TX_LOCK(), gets preempted and then taskB on cpuX wants also to send
send a packet. The second one throws the warning.

We could ignore this check because a deadlock will throw a warning and
"halt" the task that runs into the deadlock.
But then we could be smart about this in the same way !RT is and
pro-active check for the simple deadlock. The lock owner of
netdev_queue::_xmit_lock is recorded can be checked vs current.

The snippet below should work. I need to see if tomorrow this is still a
good idea.

diff --git a/net/core/dev.c b/net/core/dev.c
index 6ff4256700e60..de342ceb17201 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4821,7 +4821,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net_device *sb_dev)
 		/* Other cpus might concurrently change txq->xmit_lock_owner
 		 * to -1 or to their cpu id, but not to our id.
 		 */
-		if (READ_ONCE(txq->xmit_lock_owner) != cpu) {
+		if (rt_mutex_owner(&txq->_xmit_lock.lock) != current) {
 			if (dev_xmit_recursion())
 				goto recursion_alert;
 

> Bert Karwatzki

Sebastian
