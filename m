Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B5267398
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 May 2025 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042069; cv=none; b=sa2+5MabC9dkXTmnvZul0qXUmjAOhfQFewxesr7GQyTTirOe7xMyJv3yXDUFnDDiG9amlCXOGGXETLAvOJRD6r8dZf5g5eHvsZdztyzOSVxd7csVBt06ZrH9yLPftiDh2gnnP/ahozGZvkQbFXKjS1ZJDS4+tYlnh790PU139mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042069; c=relaxed/simple;
	bh=qh7J470CfBzEAxPn480T84rM83kcQmcrW3pOpjRCrUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhrrhUkKRZhVynKS6U3Vc0kciXWUwqy7xb3Fuly9isDXaBGPpY0mrrPO2DP8+ZwQLdhUQMwUh3LJpHjqvPWO1TdJHngjnhfWor5KYr6MBY+zya1RaebaDiFGDSNj6pxwN2tRN/5qdY+ic39EVyvehGK4yoPjOuhuNFLc0bFwtJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xvubmppU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7n6dRn+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xvubmppU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7n6dRn+O"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsMfkLJ9HsyUQY66xrCa1JuJnqr79xX6s1kOfdl4qFw=;
	b=xvubmppUzUFSY7E8bkHeuuC8Xm2keFu6Gdbn7e7bDnOp3DnQYyopeiYu3P/yWVq6Q5kUVG
	Vc346zWvtzRjNKWrG58SvWKusqi03zl91NY6OrW4u+5Tx1klNZrvXa4gSfS3WX/utKZb4V
	7wCWC9S6KIWO7oJuqVwMVfxCQLXBm8LJRZuyh0VmwI+dvhuAgTtqin3gdDa78fpUDBxyXa
	OoRyj4zQ+JMsxCbZJx9LFAkexxNhse3b7VucVvqg9Z4ACoNXR8piBeYJcOrO5CogRZPOol
	i0fkNq9F2Vt+afrYExpmWNBxIZ+Q6U27T+556874u5ZfNaZI7aN8euFzysqqeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RsMfkLJ9HsyUQY66xrCa1JuJnqr79xX6s1kOfdl4qFw=;
	b=7n6dRn+Oo/EQF4IhaJgpPkBdNgiM5Nq86Ga0dGyhR4tJkE9LRbTlXH/tBoRIHl2Bi0AHpQ
	mBwmjmzt9QA/OoBQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net-next v4 05/15] xdp: Use nested-BH locking for system_page_pool
Date: Mon, 12 May 2025 11:27:26 +0200
Message-ID: <20250512092736.229935-6-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

system_page_pool is a per-CPU variable and relies on disabled BH for its
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Make a struct with a page_pool member (original system_page_pool) and a
local_lock_t and use local_lock_nested_bh() for locking. This change
adds only lockdep coverage and does not alter the functional behaviour
for !PREEMPT_RT.

Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>
Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/netdevice.h |  7 ++++++-
 net/core/dev.c            | 15 ++++++++++-----
 net/core/xdp.c            | 15 ++++++++++-----
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 7ea022750e4e0..138bd7f3d2bef 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3502,7 +3502,12 @@ struct softnet_data {
 };
=20
 DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
-DECLARE_PER_CPU(struct page_pool *, system_page_pool);
+
+struct page_pool_bh {
+	struct page_pool *pool;
+	local_lock_t bh_lock;
+};
+DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
=20
 #ifndef CONFIG_PREEMPT_RT
 static inline int dev_recursion_level(void)
diff --git a/net/core/dev.c b/net/core/dev.c
index 11da1e272ec20..3c49366cda560 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
  * PP consumers must pay attention to run APIs in the appropriate context
  * (e.g. NAPI context).
  */
-DEFINE_PER_CPU(struct page_pool *, system_page_pool);
+DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 #ifdef CONFIG_LOCKDEP
 /*
@@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const=
 struct bpf_prog *prog)
 	struct sk_buff *skb =3D *pskb;
 	int err, hroom, troom;
=20
-	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	err =3D skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, =
prog);
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
+	if (!err)
 		return 0;
=20
 	/* In case we have to go down the path and also linearize,
@@ -12619,7 +12624,7 @@ static int net_page_pool_create(int cpuid)
 		return err;
 	}
=20
-	per_cpu(system_page_pool, cpuid) =3D pp_ptr;
+	per_cpu(system_page_pool.pool, cpuid) =3D pp_ptr;
 #endif
 	return 0;
 }
@@ -12749,13 +12754,13 @@ static int __init net_dev_init(void)
 		for_each_possible_cpu(i) {
 			struct page_pool *pp_ptr;
=20
-			pp_ptr =3D per_cpu(system_page_pool, i);
+			pp_ptr =3D per_cpu(system_page_pool.pool, i);
 			if (!pp_ptr)
 				continue;
=20
 			xdp_unreg_page_pool(pp_ptr);
 			page_pool_destroy(pp_ptr);
-			per_cpu(system_page_pool, i) =3D NULL;
+			per_cpu(system_page_pool.pool, i) =3D NULL;
 		}
 	}
=20
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a7..8696e8ffa3bcc 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -737,25 +737,27 @@ static noinline bool xdp_copy_frags_from_zc(struct sk=
_buff *skb,
  */
 struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 {
-	struct page_pool *pp =3D this_cpu_read(system_page_pool);
 	const struct xdp_rxq_info *rxq =3D xdp->rxq;
 	u32 len =3D xdp->data_end - xdp->data_meta;
 	u32 truesize =3D xdp->frame_sz;
-	struct sk_buff *skb;
+	struct sk_buff *skb =3D NULL;
+	struct page_pool *pp;
 	int metalen;
 	void *data;
=20
 	if (!IS_ENABLED(CONFIG_PAGE_POOL))
 		return NULL;
=20
+	local_lock_nested_bh(&system_page_pool.bh_lock);
+	pp =3D this_cpu_read(system_page_pool.pool);
 	data =3D page_pool_dev_alloc_va(pp, &truesize);
 	if (unlikely(!data))
-		return NULL;
+		goto out;
=20
 	skb =3D napi_build_skb(data, truesize);
 	if (unlikely(!skb)) {
 		page_pool_free_va(pp, data, true);
-		return NULL;
+		goto out;
 	}
=20
 	skb_mark_for_recycle(skb);
@@ -774,13 +776,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
 	if (unlikely(xdp_buff_has_frags(xdp)) &&
 	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
 		napi_consume_skb(skb, true);
-		return NULL;
+		skb =3D NULL;
+		goto out;
 	}
=20
 	xsk_buff_free(xdp);
=20
 	skb->protocol =3D eth_type_trans(skb, rxq->dev);
=20
+out:
+	local_unlock_nested_bh(&system_page_pool.bh_lock);
 	return skb;
 }
 EXPORT_SYMBOL_GPL(xdp_build_skb_from_zc);
--=20
2.49.0

