Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B83267732
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Jul 2025 16:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164651; cv=none; b=sKQ8JitYMAc6E/+iabbPwdDo13cerivBKN8UIkuhka/yZ2PE2J7x2D+zyFkBFe9WlYCgxk/QWr4/C7JCu5w5e0ktoN6MXvnXsd/5mbrmd5r0eH1h14ihCcEGpytzc6HIg7Lb2BUzDtEEMfPZ1iK+YIQ4mffiauEGllMdt95tKkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164651; c=relaxed/simple;
	bh=Nt/mxQwR9BHFERWG3gVd7qff4GIVOPvtHEwxRj+BzrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WuM0LcIKv5ENfnDSK0VpHjlKCLfDeXExvcfwCoosekU1+npKnzbe+3Knv07unHTzR+Xw3MjnFpzAG0khyIEzqYeBzIS0TNCLzCidDE6F3r8IpRVl/u/cVmlQt7dsF2P6jCYXgnnY3zCtCIkGZbtpLKqUS+NiqTDXJZ3BT9CnKJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lPndDSuR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0udAy9u; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lPndDSuR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0udAy9u"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752164648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/Iqc0Qv/EyWLhvL/8oM13N1J8XqmbsP5dvIomNh/rg=;
	b=lPndDSuR2iSssiW0HRojwXRzaZgznHyCObevaKltpxGzg2niSGNtJIV5wQzt6JrSeCqkMA
	9mRxK8r74x7wDV5wFArF+Ngo3RP8Mf0QrhEl0vEkLqfaIxDTOwuB8zUohOeLeCS+aEyyUS
	dqZKGXpPz5T/22goaWgLsEkPpW767fY4G7T2nmzLDrVb3Of07x0+Z/rB0NWoCEfC6iWP46
	x6sAwmcNQz/5PK4l+6YIJykwwujHufDDNPXLejRA4wyg86P51q6yAyJxoRvR8LdiltInHV
	/p49Eh2yWiPUu9u6X/4SnGp0zNPIrcvDULONh2i0t8JiKRptVjn/ycsWnGEYZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752164648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B/Iqc0Qv/EyWLhvL/8oM13N1J8XqmbsP5dvIomNh/rg=;
	b=I0udAy9uJk4rzTBeF6nIA87bPUlJkIuXeFMvgkABCKrbiz1U0x8XZ1L3aiA4+1VyLNTFQO
	NnHPwJw2ysByprBw==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH net-next v2 1/1] ppp: Replace per-CPU recursion counter with lock-owner field
Date: Thu, 10 Jul 2025 18:24:03 +0200
Message-ID: <20250710162403.402739-2-bigeasy@linutronix.de>
In-Reply-To: <20250710162403.402739-1-bigeasy@linutronix.de>
References: <20250710162403.402739-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The per-CPU variable ppp::xmit_recursion is protecting against recursion
due to wrong configuration of the ppp channels. The per-CPU variable
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
index def84e87e05b2..0edc916e0a411 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -119,6 +119,11 @@ struct ppp_link_stats {
 	u64 tx_bytes;
 };
=20
+struct ppp_xmit_recursion {
+	struct task_struct *owner;
+	local_lock_t bh_lock;
+};
+
 /*
  * Data structure describing one ppp unit.
  * A ppp unit corresponds to a ppp network interface device
@@ -132,7 +137,7 @@ struct ppp {
 	int		n_channels;	/* how many channels are attached 54 */
 	spinlock_t	rlock;		/* lock for receive side 58 */
 	spinlock_t	wlock;		/* lock for transmit side 5c */
-	int __percpu	*xmit_recursion; /* xmit recursion detect */
+	struct ppp_xmit_recursion __percpu *xmit_recursion; /* xmit recursion det=
ect */
 	int		mru;		/* max receive unit 60 */
 	unsigned int	flags;		/* control bits 64 */
 	unsigned int	xstate;		/* transmit state bits 68 */
@@ -1262,13 +1267,18 @@ static int ppp_dev_configure(struct net *src_net, s=
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
@@ -1683,15 +1693,20 @@ static void __ppp_xmit_process(struct ppp *ppp, str=
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
@@ -2193,11 +2208,16 @@ static void __ppp_channel_push(struct channel *pch)
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

