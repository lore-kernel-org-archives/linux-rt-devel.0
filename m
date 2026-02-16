Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1111238FA3
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Feb 2026 23:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771285731; cv=none; b=POae5zWddih3mFJZR6boUjzRl38gyk2E3eV14quiASFoMGRtcn6/diE4c03jzClMrFqZutEhwBgUmbA5H/a8JFuNac5GXZ62UR1xfJSDYGmmd7vwJJgI/a+8lxrDKQsbjIGf+/zrvkvxVz78ObWSuSRDaV0YuiRbwyRnAnS4QVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771285731; c=relaxed/simple;
	bh=67GuGJu91b0XngYmPKUShyRf2qBjoeXTTL/6Ij3TDJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=an2mpT5B8fgLkAV2ystY2E2OUo9hdEDSCEi7HTZyrdRIWiHkmp0u+UqyaTB8frQ9Ry5DX07FyqD5NQF747QmhaaF6diSRFrdcbXvDFsr5pF5b7qMhWEpmbYp83wBPaRIYURm6/He4WpU4SwtyYHEhioQxYv6qKUy8K+A8DdB9O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=IKfKSckK; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="IKfKSckK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1771285707; x=1771890507; i=spasswolf@web.de;
	bh=X6RG5TkFMYK4+JwDKie6/NZvHG7yfJFdBs29nKDq00Y=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=IKfKSckKhaUX9FQwjGZilYAnkNletBxNy/od1Ao4HzpxbFeqXKPBpzDhIk4crzCn
	 TklWXwnOPzw7rM7OA2/HanqJl3gIi3ZFnwzcL9azCrWWk3JQH6wrrodDE6lMrJDFN
	 EFLewyMYq8fob308tIw1t1WanFL2s9NFDAUmMLF7bDMaEpbjKXiRC2d3bB6+oXca/
	 PqWd/KRpLvaQMtEnLksETXUYai9SVdclOEuZUTM3OtvdbRTV9J+z0KCY4NNeRInfW
	 7PVBFbQJBk2fOQKXCPWV6QFTTscMzktww8LCsspRqoKcMvKJu7ecoBwHqi6xiWYOB
	 c/fLHIREUApIcx9wtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MK56y-1wCXWW2cqk-00Qzfx; Tue, 17
 Feb 2026 00:48:26 +0100
Message-ID: <37d6e27f96afb57c5716798530cb3560d25202e5.camel@web.de>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
From: Bert Karwatzki <spasswolf@web.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, spasswolf@web.de
Date: Tue, 17 Feb 2026 00:48:25 +0100
In-Reply-To: <20260216153745.CA3__zRc@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
		 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
		 <20260216153745.CA3__zRc@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:45oP4sigcS+baR5+tgn8RKwYMgeXgyT4xih5Cnc9XGHmuQebVWj
 Xa5YJVMVARx2OETtLFox34TFqWwCV8fByzC/855sCA8RGSQ3GSevUv/CMYqhfCbXBrcU4Rk
 wLp0tpS2H5qNqTbGNGzx20cXHOXysdujbwPVubBcj14YyGbSJBo8I4kkCx/7Cs6+eb2WOxf
 AS2Tnht/wEr6JrpPOyOoA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S5/+2LbUfys=;BCgc05aGT9u+GPrUfYXRy3F8TOc
 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
 H4zNWGjY=

Am Montag, dem 16.02.2026 um 16:37 +0100 schrieb Sebastian Andrzej Siewior=
:
>=20
> I am not sure what issue is so I can't tell. The dev_xmit_recursion*()
> based counters are per-task so it should be fine. But yet the wifi
> managed to repeatedly enqueue packets. This might be a real recursion, a
> stack trace should tell. And then, somewhere synchronisation is missing.
>=20
> > Bert Karwatzki
>=20
> Sebastian

The problem seems to be that different preemtible threads try to send skbs=
.=20

I used this debug patch for 6.18.10:

diff --git a/net/core/dev.c b/net/core/dev.c
index 5b536860138d..ecfdd8e3dc99 100644
=2D-- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4704,6 +4704,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net=
_device *sb_dev)
=20
 	qdisc_pkt_len_init(skb);
 	tcx_set_ingress(skb, false);
+	printk(KERN_INFO "%s 0: skb =3D %px dev =3D %s\n", __func__, skb, dev->n=
ame);
 #ifdef CONFIG_NET_EGRESS
 	if (static_branch_unlikely(&egress_needed_key)) {
 		if (nf_hook_egress_active()) {
@@ -4739,10 +4740,12 @@ int __dev_queue_xmit(struct sk_buff *skb, struct n=
et_device *sb_dev)
=20
 	trace_net_dev_queue(skb);
 	if (q->enqueue) {
+		printk(KERN_INFO "%s 1: skb =3D %px dev =3D %s\n", __func__, skb, dev->=
name);
 		rc =3D __dev_xmit_skb(skb, q, dev, txq);
 		goto out;
 	}
=20
+	printk(KERN_INFO "%s 2: skb =3D %px dev =3D %s txq =3D %px\n", __func__,=
 skb, dev->name, txq);
 	/* The device has no queue. Common case for software devices:
 	 * loopback, all the sorts of tunnels...
=20
@@ -4761,15 +4764,20 @@ int __dev_queue_xmit(struct sk_buff *skb, struct n=
et_device *sb_dev)
 		/* Other cpus might concurrently change txq->xmit_lock_owner
 		 * to -1 or to their cpu id, but not to our id.
 		 */
+		printk(KERN_INFO "%s: cpu =3D %d xmit_lock_owner =3D %d\n", __func__, c=
pu, READ_ONCE(txq->xmit_lock_owner));
 		if (READ_ONCE(txq->xmit_lock_owner) !=3D cpu) {
-			if (dev_xmit_recursion())
+			printk(KERN_INFO "%s 3: skb =3D %px dev =3D %s txq =3D %px\n", __func_=
_, skb, dev->name, txq);
+			if (dev_xmit_recursion()) {
+				printk(KERN_INFO "%s: recursion alert for device %s!\n", __func__, de=
v->name);
 				goto recursion_alert;
+			}
=20
 			skb =3D validate_xmit_skb(skb, dev, &again);
 			if (!skb)
 				goto out;
=20
 			HARD_TX_LOCK(dev, txq, cpu);
+			printk(KERN_INFO "%s 4: skb =3D %px dev =3D %s txq =3D %px\n", __func_=
_, skb, dev->name, txq);
=20
 			if (!netif_xmit_stopped(txq)) {
 				dev_xmit_recursion_inc();
@@ -4777,6 +4785,7 @@ int __dev_queue_xmit(struct sk_buff *skb, struct net=
_device *sb_dev)
 				dev_xmit_recursion_dec();
 				if (dev_xmit_complete(rc)) {
 					HARD_TX_UNLOCK(dev, txq);
+					printk(KERN_INFO "%s 5: skb =3D %px dev =3D %s txq =3D %px\n", __fun=
c__, skb, dev->name, txq);
 					goto out;
 				}
 			}

The normal path of an skb is this:
2026-02-17T00:29:24.124757+01:00 [ T1522] __dev_queue_xmit 0: skb =3D ffff=
8c11ed06bd00 dev =3D wlp4s0
2026-02-17T00:29:24.124845+01:00 [ T1522] __dev_queue_xmit 2: skb =3D ffff=
8c11ed06bd00 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.124851+01:00 [ T1522] __dev_queue_xmit: cpu =3D 7 xmit=
_lock_owner =3D -1
2026-02-17T00:29:24.124853+01:00 [ T1522] __dev_queue_xmit 3: skb =3D ffff=
8c11ed06bd00 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.124855+01:00 [ T1522] __dev_queue_xmit 4: skb =3D ffff=
8c11ed06bd00 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.124857+01:00 [ T1522] __dev_queue_xmit 5: skb =3D 0000=
000000000000 dev =3D wlp4s0 txq =3D ffff8c1145320200

This is the situation which produces the error messages:

T1522 tries to send an skb on CPU 7:
2026-02-17T00:29:24.212215+01:00 [ T1522] __dev_queue_xmit 0: skb =3D ffff=
8c11ed06b100 dev =3D wlp4s0
2026-02-17T00:29:24.212217+01:00 [ T1522] __dev_queue_xmit 2: skb =3D ffff=
8c11ed06b100 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.212219+01:00 [ T1522] __dev_queue_xmit: cpu =3D 7 xmit=
_lock_owner =3D -1
2026-02-17T00:29:24.212221+01:00 [ T1522] __dev_queue_xmit 3: skb =3D ffff=
8c11ed06b100 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.212223+01:00 [ T1522] __dev_queue_xmit 4: skb =3D ffff=
8c11ed06b100 dev =3D wlp4s0 txq =3D ffff8c1145320200=20
Here T1522 gets preempted and T1513 is executed on CPU 7 and also tries to=
 send an skb:
2026-02-17T00:29:24.212225+01:00 [ T1513] __dev_queue_xmit 0: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0
2026-02-17T00:29:24.212228+01:00 [ T1513] __dev_queue_xmit 2: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.212230+01:00 [ T1513] __dev_queue_xmit: cpu =3D 7 xmit=
_lock_owner =3D 7
2026-02-17T00:29:24.212231+01:00 [ T1513] Dead loop on virtual device wlp4=
s0, fix it urgently!
2026-02-17T00:29:24.212234+01:00 [ T1513] __dev_queue_xmit 0: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0
2026-02-17T00:29:24.212236+01:00 [ T1513] __dev_queue_xmit 2: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.212238+01:00 [ T1513] __dev_queue_xmit: cpu =3D 7 xmit=
_lock_owner =3D 7
2026-02-17T00:29:24.212240+01:00 [ T1513] Dead loop on virtual device wlp4=
s0, fix it urgently!
2026-02-17T00:29:24.212242+01:00 [ T1513] __dev_queue_xmit 0: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0
2026-02-17T00:29:24.212244+01:00 [ T1513] __dev_queue_xmit 2: skb =3D ffff=
8c11ed06a300 dev =3D wlp4s0 txq =3D ffff8c1145320200
2026-02-17T00:29:24.212246+01:00 [ T1513] __dev_queue_xmit: cpu =3D 7 xmit=
_lock_owner =3D 7
2026-02-17T00:29:24.212247+01:00 [ T1513] Dead loop on virtual device wlp4=
s0, fix it urgently!
T1513 gets preempted and T1522 finishes processing the skb from above:
2026-02-17T00:29:24.212249+01:00 [ T1522] __dev_queue_xmit 5: skb =3D 0000=
000000000000 dev =3D wlp4s0 txq =3D ffff8c1145320200

Bert Karwatzki
