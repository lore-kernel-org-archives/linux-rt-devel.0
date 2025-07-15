Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B02063F0
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Jul 2025 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592095; cv=none; b=YfR1hnPLIqwjBlMXLi6IpMYyjmFpm9YdnsCaIpQjsP4pNfwGLSrko7knps0632GSn5gCUEuVFYHElWEn3I5jVMVLk00UYaIQgJM89ebUl7CDyCdnJfT11DQ0tWY3bd0h3A9/Gi9cK9T10mddv7IGQrXKc6K70oupKxcZyJ5En+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592095; c=relaxed/simple;
	bh=lblXFIyV/JWPb5HAJrgwuepip6tVSl/rd8mDx7IOCaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idhI9KTHydOecQJEi3UNOjVujaS6OWR5DFdAT/eP/i3QivOEkpDpA4npacU2Avn7GEZYRu99dBX8B36QbDs8gcGSvFiR6/ImbWhw38clpFEoanrpL+/yoqXJESS+2l0WkSoK2npoeXB0P7ffEJCYIT4aLDf1BKf9G3Y92Kpdxzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nVVDzQ9g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UjtanNKx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nVVDzQ9g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UjtanNKx"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752592090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5iI+kNEItwpwsaQyFlg7rE3TnX2RE+YRDU9nLCwDFo=;
	b=nVVDzQ9gwT29vO7zyltrX1u5L077BBnU3I9xJoUdBWTt5tTPocZtUrT2g/VwmaRHYojrPK
	PoEpZa/ZOfwiJt4FqIH9RFs4W3e777+gfj2WpCNAn9ChuGekxWHGdSoO9u/4KiLs0RIUAs
	LpFOupOdWLuASEUO4R5aCWS/7VIaDosQV+VM3TWE+dhj8T0QxzJq1j0e5HLpYPzy+eiuJc
	8p53TKvBBqVERVd8UmOjx8e7mVKveM4h4mVhH+yeYBTk+JcEi0kY3u5TGgUEAS//PAgjV5
	iZWo6Qyi75ONJvv7qD6a8CrevafZmczZ6/FoPUTkernLZ1a2yKrLqaWIYJsXeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752592090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5iI+kNEItwpwsaQyFlg7rE3TnX2RE+YRDU9nLCwDFo=;
	b=UjtanNKxUtKMVC63KXsIob4p8jSmoRnvfztUPZWj9Dnpr8aMgING9K+9796Iz9w2yZ9SuE
	5fzc4kJTtEV+0RAA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-ppp@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Williams <clrkwllms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Guillaume Nault <gnault@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v3 1/1] ppp: Replace per-CPU recursion counter with lock-owner field
Date: Tue, 15 Jul 2025 17:08:06 +0200
Message-ID: <20250715150806.700536-2-bigeasy@linutronix.de>
In-Reply-To: <20250715150806.700536-1-bigeasy@linutronix.de>
References: <20250715150806.700536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The per-CPU variable ppp::xmit_recursion is protecting against recursion
due to wrong configuration of the ppp unit. The per-CPU variable
relies on disabled BH for its locking. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this data structure requires explicit
locking.

The ppp::xmit_recursion is used as a per-CPU boolean. The counter is
checked early in the send routing and the transmit path is only entered
if the counter is zero. Then the counter is incremented to avoid
recursion. It used to detect recursion on channel::downl and
ppp::wlock.

Create a struct ppp_xmit_recursion and move the counter into it.
Add local_lock_t to the struct and use local_lock_nested_bh() for
locking. Due to possible nesting, the lock cannot be acquired
unconditionally but it requires an owner field to identify recursion
before attempting to acquire the lock.

The counter is incremented and checked only after the lock is acquired.
Since it functions as a boolean rather than a count, and its role is now
superseded by the owner field, it can be safely removed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/net/ppp/ppp_generic.c | 38 ++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4cf9d1822a83f..8c98cbd4b06de 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -107,6 +107,11 @@ struct ppp_file {
 #define PF_TO_PPP(pf)		PF_TO_X(pf, struct ppp)
 #define PF_TO_CHANNEL(pf)	PF_TO_X(pf, struct channel)
=20
+struct ppp_xmit_recursion {
+	struct task_struct *owner;
+	local_lock_t bh_lock;
+};
+
 /*
  * Data structure describing one ppp unit.
  * A ppp unit corresponds to a ppp network interface device
@@ -120,7 +125,7 @@ struct ppp {
 	int		n_channels;	/* how many channels are attached 54 */
 	spinlock_t	rlock;		/* lock for receive side 58 */
 	spinlock_t	wlock;		/* lock for transmit side 5c */
-	int __percpu	*xmit_recursion; /* xmit recursion detect */
+	struct ppp_xmit_recursion __percpu *xmit_recursion; /* xmit recursion det=
ect */
 	int		mru;		/* max receive unit 60 */
 	unsigned int	flags;		/* control bits 64 */
 	unsigned int	xstate;		/* transmit state bits 68 */
@@ -1249,13 +1254,18 @@ static int ppp_dev_configure(struct net *src_net, s=
truct net_device *dev,
 	spin_lock_init(&ppp->rlock);
 	spin_lock_init(&ppp->wlock);
=20
-	ppp->xmit_recursion =3D alloc_percpu(int);
+	ppp->xmit_recursion =3D alloc_percpu(struct ppp_xmit_recursion);
 	if (!ppp->xmit_recursion) {
 		err =3D -ENOMEM;
 		goto err1;
 	}
-	for_each_possible_cpu(cpu)
-		(*per_cpu_ptr(ppp->xmit_recursion, cpu)) =3D 0;
+	for_each_possible_cpu(cpu) {
+		struct ppp_xmit_recursion *xmit_recursion;
+
+		xmit_recursion =3D per_cpu_ptr(ppp->xmit_recursion, cpu);
+		xmit_recursion->owner =3D NULL;
+		local_lock_init(&xmit_recursion->bh_lock);
+	}
=20
 #ifdef CONFIG_PPP_MULTILINK
 	ppp->minseq =3D -1;
@@ -1660,15 +1670,20 @@ static void __ppp_xmit_process(struct ppp *ppp, str=
uct sk_buff *skb)
=20
 static void ppp_xmit_process(struct ppp *ppp, struct sk_buff *skb)
 {
+	struct ppp_xmit_recursion *xmit_recursion;
+
 	local_bh_disable();
=20
-	if (unlikely(*this_cpu_ptr(ppp->xmit_recursion)))
+	xmit_recursion =3D this_cpu_ptr(ppp->xmit_recursion);
+	if (xmit_recursion->owner =3D=3D current)
 		goto err;
+	local_lock_nested_bh(&ppp->xmit_recursion->bh_lock);
+	xmit_recursion->owner =3D current;
=20
-	(*this_cpu_ptr(ppp->xmit_recursion))++;
 	__ppp_xmit_process(ppp, skb);
-	(*this_cpu_ptr(ppp->xmit_recursion))--;
=20
+	xmit_recursion->owner =3D NULL;
+	local_unlock_nested_bh(&ppp->xmit_recursion->bh_lock);
 	local_bh_enable();
=20
 	return;
@@ -2169,11 +2184,16 @@ static void __ppp_channel_push(struct channel *pch)
=20
 static void ppp_channel_push(struct channel *pch)
 {
+	struct ppp_xmit_recursion *xmit_recursion;
+
 	read_lock_bh(&pch->upl);
 	if (pch->ppp) {
-		(*this_cpu_ptr(pch->ppp->xmit_recursion))++;
+		xmit_recursion =3D this_cpu_ptr(pch->ppp->xmit_recursion);
+		local_lock_nested_bh(&pch->ppp->xmit_recursion->bh_lock);
+		xmit_recursion->owner =3D current;
 		__ppp_channel_push(pch);
-		(*this_cpu_ptr(pch->ppp->xmit_recursion))--;
+		xmit_recursion->owner =3D NULL;
+		local_unlock_nested_bh(&pch->ppp->xmit_recursion->bh_lock);
 	} else {
 		__ppp_channel_push(pch);
 	}
--=20
2.50.0

