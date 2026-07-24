Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2944471A
	for <linux-rt-devel@lists.linux.dev>; Fri, 24 Jul 2026 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905754; cv=none; b=UtrdaNQl7eCXyvQOftGxOmFoXcKTxgRc7+eaDpyn3UZ5iEb24IaPGlyIWgV6fPRlpBqDnDXnk6XacROBC4eLUKfuhIn7kccJ8bVlsTML0EmUABgCrmPyZoQzkpBStUGOLeM2zNdGqXdrYa9UPMkDc072IWkYGjBslTYlUkb5zh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905754; c=relaxed/simple;
	bh=xkYMIEhnTGxtu2XDSdkqj5VTpYSN6KJjm2oBoYQO3lc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DprfffAQxJAJQDzjEUZzw+QExsMEklvvbW12Gc3bdZWnHOchv9mZsOevCc979mnD0gv+q0DQ0i6mHzsDWUQmtbhes4kG4R44WyKa+sTZh8oBHPKX79wuafaDHUEG+3zpsacdQENgOS9k1k7OXXCXcGDfHS90ib7jUqNVAL9POqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=m4siRHce; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="m4siRHce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1784905730; x=1785510530; i=spasswolf@web.de;
	bh=KTPitRg5OqG7DFkkf9hLzROQQQ+Xa9l+VnBOYd+3eIg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=m4siRHcejuOtKXjMJo9T9hD2iMJyAXri7Lbb63WRD3w+lR+b0EekwCnFmptvsZmG
	 f1EmJCEyIUUiyzUfVyMHqThvE9sDvf9srLc3W1qi3uW8hRKLxhahfPt340BA+rWLf
	 HqCRn06LlgW/FWtVRvogxbE1eSuNMJQGXfT9gvFQ8CT9/uJPlCuNPTRrSIQeQIwgI
	 LXzNBZHfSGE0CMbns/fAspEAnDOjjQT5dlG02CrJjRML1IWVkvDI3XdFmC75pTOkV
	 Hvf7vWeQODgToz/sbemXzv3dEyGl00mB/6KSfiKh070gLIcycjtOh7kOGNeKnEvQ7
	 vPTR9qQkyWff49bv9A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTOli-1wQId41zpc-00JRWG; Fri, 24
 Jul 2026 17:08:50 +0200
Message-ID: <3c1be47abfcc907e7c1f9696cb25a24c93415a28.camel@web.de>
Subject: Re: [Re] kernel panic during shutdown in  next-20260722
From: Bert Karwatzki <spasswolf@web.de>
To: linux-kernel@vger.kernel.org, Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Thomas Gleixner	 <tglx@linutronix.de>,
 spasswolf@web.de
Date: Fri, 24 Jul 2026 17:08:49 +0200
In-Reply-To: <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
References: <20260723131001.11565-1-spasswolf@web.de>
				 <d24a136539c5931984f4855ad6596ca7aee8ebe2.camel@web.de>
		 <1a0800888c2fcd42f1fcd661d8f6f50580ac2fd4.camel@web.de>
	 <4d7c2dd588cd77d1d112da473f2a262d22051d57.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:32dZAA2tRTANj96ZVzU2y0p/gW0M6MfUirGiLeepCc9u6MCYYWH
 QpFHY6MIbNPb8MlbrIN/Stggmw4gCBkiWdOGQafpwNEZtleOX3reClBvKGmYLxRVEMEB1An
 f+1MUXgI013ioKWqaBz1nwmT6q9ehrIrpXk5RINA/w1ULnXnSQWsCI4APUmaU4lSP3xyzMb
 hI0HMgnWJkXUZ8kPWFTvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rNImO22Yll8=;XFazeNhHg60WIPC8J/r6pH+WFkv
 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

Am Freitag, dem 24.07.2026 um 00:51 +0200 schrieb Bert Karwatzki:
> Am Donnerstag, dem 23.07.2026 um 18:17 +0200 schrieb Bert Karwatzki:
> > Am Donnerstag, dem 23.07.2026 um 15:23 +0200 schrieb Bert Karwatzki:
> > > Am Donnerstag, dem 23.07.2026 um 15:10 +0200 schrieb Bert Karwatzki:
> > > > I was able to gather the panic error message from a failed shutdow=
n via netconsole,
> > > > this time the kernel used was v7.2-rc3:
> > > > #
> > > > Bert Karwatzki
> > >=20
> > > Unfortunatetly I can now reproduce these kernel panics in v7.1:
> > >=20
> > >=20
> > > So now I'm going to use memtest86+ on my machine and then look at th=
e changes I had in
> > > my userspace as the first error occured on 22.7.2026. Let's hope thi=
s does not escalate ...
> > >=20
> > > Bert Karwatzki
> >=20
> >=20
> > But I found out an exciting thing:
> > I can only reproduce the crashes in v7.2-rc4 when watching the reboot =
via netconsole,
> > without netconsole no crash occurs!(This also explains why I had not s=
een this crashes before ...)=C2=A0
> >=20
> Actually this is not cause by netconsole, but by rebooting right after a=
 crash. Some
> broken state seems to be preserved across reboots. Switching off the pow=
er supply after
> a crash or even a ~30s wait after switching off the crashed machine seem=
s to be enough
> to get around this.
>  Also the hang when rebooting next-20260722 also occurs when compiling w=
ithout PREEMPT_RT.
>=20
> Bert Karwatzki

There are actually several errors here:
1) The shutdown hang wich occurs in next-20260722+ (PREMPT_RT or not)
This error is caused by (I'll open a separate thread for this):

commit 13b7e6a96a005c656d38f3da51581deaf9866375
Author: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Date:   Wed Jul 8 16:43:47 2026 +0200

    wifi: mt76: Disable napi when removing device
   =20
    Unloading the mt7915e module with a MT7916 triggers multiples WARN in
    __netif_napi_del_locked() and in page_pool_disable_direct_recycling()
    because the driver does not disable the napi before destroying it.
   =20
    This is troublesome since on MT7916 it is required to unload the modul=
e
    and reinsert it with a different enable_6ghz parameter to change the
    frequency.  The system generally becomes unstable after reinserting th=
e
    module.
   =20
    Fix it by disabling napi before deleting it.  Also, do not delete napi
    on WED queues since napi is neither used nor initialized on them.
   =20
    Fixes: 17f1de56df05 ("mt76: add common code shared between multiple ch=
ipsets")
    Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communicatio=
ns.fr>
    Link: https://patch.msgid.link/20260708144615.24092-1-nicolas.cavallar=
i@green-communications.fr
    Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirele=
ss/mediatek/mt76/dma.c
index f8c2fe5f2f58..322041859217 100644
=2D-- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -1189,7 +1189,10 @@ void mt76_dma_cleanup(struct mt76_dev *dev)
        mt76_for_each_q_rx(dev, i) {
                struct mt76_queue *q =3D &dev->q_rx[i];
=20
-               netif_napi_del(&dev->napi[i]);
+               if (!mt76_queue_is_wed_rro(q)) {
+                       napi_disable(&dev->napi[i]);
+                       netif_napi_del(&dev->napi[i]);
+               }
                mt76_dma_rx_cleanup(dev, q);
=20
                page_pool_destroy(q->page_pool);


2) The "scheduling while atomic" errors which occur in v7.2-rc4 and earlie=
r, once I figure out
these I'll contiue here (v6.19 is free from these errors)

Bert Karwatzki
