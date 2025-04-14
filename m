Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A49284698
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Apr 2025 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646898; cv=none; b=blZ0mIA+GaQuriHwFjVs4Fh/OUhh8I9ey735uZ0FNOxnXi8phmr8FvBYV3CJSWoghU230fmG+y0bivgRX1TtqaSDd0bGEo57cQPX/sq47+20IYPdxUlaojXLau0qtIdkTHazg3jp2sAj1lx8X8AxZoXy8ef4TDK0r9ELW3l3dJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646898; c=relaxed/simple;
	bh=psMK5D/Ej6r9TOHK0/N777uNZ7fI4FJf9tekZNqyEP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcR+GJnO+5+as72rV1RBQLZxyzUaDjmGA2O/CZaUVQooSm/kmM5eTtFJSPrYu1rEx2PTXhgOf3ji9vj1QG0VjyzAlcUEQDGFI6yGJsCJHh9b335WM7HD85RefM6lAVgW8G/lVNwtkR0MYQ5gNioBfxy9Mu+C28m3SkNuTcw1uaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UweF2BbX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xlUvTn8O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UweF2BbX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xlUvTn8O"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9V0amf8yCnsZjanHGDleuk2ou6MuA9/QgqDODlZotE=;
	b=UweF2BbXcEz4vcWWIeBB4PO+6elYVD4F1vDlQY80Ogf2DrYxj7JYBa0TGNtjld/k0FAIiU
	Z3QM5xf1cFxIMytPlL96UQhVves5TcRjDwAk2YWMrIL6OhrIU7FWZeahofmXEGF1sv62t7
	FupN8WNK9tBKKMT97wZwtJ7DzqGSxfCNucwtvG2Xxv82CQXrDl3WfJU65W6NXApBNzjWBF
	+8dHuGndj+X3IoAn5YX0eHN1uR+vCbsEZq2OFPidMLm/4DxEG3kpt8k1HC6vJWROZ7F6/F
	zqYSt4emBIUnLbyuaVajV1XPo9b8uAosCo7aqxjeMl7kmSLLf/p+IbTineNqKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g9V0amf8yCnsZjanHGDleuk2ou6MuA9/QgqDODlZotE=;
	b=xlUvTn8OtwmKyqUsih+ilHZhjUDM4doduM5Q1XmSuyO7iFbT9Ivj9pzFZfAcXyXF0ByMVi
	DcuxW5su2W0wa1DA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v2 14/18] net/sched: Use nested-BH locking for sch_frag_data_storage
Date: Mon, 14 Apr 2025 18:07:50 +0200
Message-ID: <20250414160754.503321-15-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

sch_frag_data_storage is a per-CPU variable and relies on disabled BH
for its locking. Without per-CPU locking in local_bh_disable() on
PREEMPT_RT this data structure requires explicit locking.

Add local_lock_t to the struct and use local_lock_nested_bh() for locking.
This change adds only lockdep coverage and does not alter the functional
behaviour for !PREEMPT_RT.

Cc: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/sched/sch_frag.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index ce63414185fd6..d1d87dce7f3f7 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -16,14 +16,18 @@ struct sch_frag_data {
 	unsigned int l2_len;
 	u8 l2_data[VLAN_ETH_HLEN];
 	int (*xmit)(struct sk_buff *skb);
+	local_lock_t bh_lock;
 };
=20
-static DEFINE_PER_CPU(struct sch_frag_data, sch_frag_data_storage);
+static DEFINE_PER_CPU(struct sch_frag_data, sch_frag_data_storage) =3D {
+	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
+};
=20
 static int sch_frag_xmit(struct net *net, struct sock *sk, struct sk_buff =
*skb)
 {
 	struct sch_frag_data *data =3D this_cpu_ptr(&sch_frag_data_storage);
=20
+	lockdep_assert_held(&data->bh_lock);
 	if (skb_cow_head(skb, data->l2_len) < 0) {
 		kfree_skb(skb);
 		return -ENOMEM;
@@ -95,6 +99,7 @@ static int sch_fragment(struct net *net, struct sk_buff *=
skb,
 		struct rtable sch_frag_rt =3D { 0 };
 		unsigned long orig_dst;
=20
+		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
 		sch_frag_prepare_frag(skb, xmit);
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
@@ -105,11 +110,13 @@ static int sch_fragment(struct net *net, struct sk_bu=
ff *skb,
 		IPCB(skb)->frag_max_size =3D mru;
=20
 		ret =3D ip_do_fragment(net, skb->sk, skb, sch_frag_xmit);
+		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else if (skb_protocol(skb, true) =3D=3D htons(ETH_P_IPV6)) {
 		unsigned long orig_dst;
 		struct rt6_info sch_frag_rt;
=20
+		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
 		sch_frag_prepare_frag(skb, xmit);
 		memset(&sch_frag_rt, 0, sizeof(sch_frag_rt));
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
@@ -122,6 +129,7 @@ static int sch_fragment(struct net *net, struct sk_buff=
 *skb,
=20
 		ret =3D ipv6_stub->ipv6_fragment(net, skb->sk, skb,
 					       sch_frag_xmit);
+		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
 		net_warn_ratelimited("Fail frag %s: eth=3D%x, MRU=3D%d, MTU=3D%d\n",
--=20
2.49.0

