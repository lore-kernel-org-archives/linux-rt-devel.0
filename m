Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE4267AE9
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 May 2025 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042070; cv=none; b=riI1868j4+BlNGqC+iwS540Sz8w0LHHjAIAuZFVwthqlHxoUtirSE5Lx2h7zAI1ZUI2lxZJBdYdg1T/vU+7uQD5hb7ZqTXbAC2aypcaD4SO0/uz01wZfDWbUP/KatuHopL4t4vzLLDeft73YXh12MyZskPZ7c2lc8Sb3bXuZAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042070; c=relaxed/simple;
	bh=sPkDhpPj45NqnNG7OXTUxNK+pKVoxq7lSZ7ppnTOfa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8QDaI0f+DfDXoNU+7hJkdqr0DgdAzd73IBuYtIvBwP5GjXTFUBTgj3fGhUnXRaeyouMo+rytOMC2okFhhpe73TH7fC/5cIXDY5uEQPHel7ccvTOvTZVMw7PvCxbtWECyTzFOCCBAoLRpHG2lmRXqPiYXe3fsojTkb6PGM2wCPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fchQmaa9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e12Wpaqs; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fchQmaa9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e12Wpaqs"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747042065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1x3iY/bAzLdbqw/dUByEQjXdETe5UjtT7mP0YXW3+s=;
	b=fchQmaa9C3mm1Uk1Z6s+I/ZNCrthXg65qj+FXfNDhruxu6TN6x2575eoyY7iGAG8tLzmrj
	WGeYaSjVA50spZnuzOu9KNqCahktx/LYveNQF0LkCH6VaGiVBl89S+gWkRLzqqEYR01OEj
	9x+p0nMPAzLi2gEEIQvXLFZiyYr/nt8vCEkSK69FL70tKxeY4VYj9ZNyeQmeVuOwnumxj+
	yGi3tG4EL2nJ5ZUzjGcooe0KcuaME3WPZs8JlsiIHTou5OaVcH0+1DekLaKSZ5/pmNRnmq
	iRMBtblRU6zI6nleM/bvB9XfkBKLjFztTErKnZHF9z/c6ubq75vOWAOUxUoN6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747042065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N1x3iY/bAzLdbqw/dUByEQjXdETe5UjtT7mP0YXW3+s=;
	b=e12Wpaqsv8goAdawMy185jytMKpcgFAMMwC7dpT6OKcATDyVIcp3558nLLl1XcTjzfZfGQ
	zP8wlsQChjb/5vCA==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v4 09/15] openvswitch: Move ovs_frag_data_storage into the struct ovs_pcpu_storage
Date: Mon, 12 May 2025 11:27:30 +0200
Message-ID: <20250512092736.229935-10-bigeasy@linutronix.de>
In-Reply-To: <20250512092736.229935-1-bigeasy@linutronix.de>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

ovs_frag_data_storage is a per-CPU variable and relies on disabled BH for i=
ts
locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
this data structure requires explicit locking.

Move ovs_frag_data_storage into the struct ovs_pcpu_storage which already
provides locking for the structure.

Cc: Aaron Conole <aconole@redhat.com>
Cc: Eelco Chaudron <echaudro@redhat.com>
Cc: Ilya Maximets <i.maximets@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c  | 20 ++------------------
 net/openvswitch/datapath.h | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 435725c27a557..e7269a3eec79e 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -39,22 +39,6 @@
 #include "flow_netlink.h"
 #include "openvswitch_trace.h"
=20
-#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
-struct ovs_frag_data {
-	unsigned long dst;
-	struct vport *vport;
-	struct ovs_skb_cb cb;
-	__be16 inner_protocol;
-	u16 network_offset;	/* valid only for MPLS */
-	u16 vlan_tci;
-	__be16 vlan_proto;
-	unsigned int l2_len;
-	u8 mac_proto;
-	u8 l2_data[MAX_L2_LEN];
-};
-
-static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
-
 DEFINE_PER_CPU(struct ovs_pcpu_storage, ovs_pcpu_storage) =3D {
 	.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
 };
@@ -771,7 +755,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow=
_key *flow_key,
 static int ovs_vport_output(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_pcpu_storage.frag_data);
 	struct vport *vport =3D data->vport;
=20
 	if (skb_cow_head(skb, data->l2_len) < 0) {
@@ -823,7 +807,7 @@ static void prepare_frag(struct vport *vport, struct sk=
_buff *skb,
 	unsigned int hlen =3D skb_network_offset(skb);
 	struct ovs_frag_data *data;
=20
-	data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	data =3D this_cpu_ptr(&ovs_pcpu_storage.frag_data);
 	data->dst =3D skb->_skb_refdst;
 	data->vport =3D vport;
 	data->cb =3D *OVS_CB(skb);
diff --git a/net/openvswitch/datapath.h b/net/openvswitch/datapath.h
index 4a665c3cfa906..1b5348b0f5594 100644
--- a/net/openvswitch/datapath.h
+++ b/net/openvswitch/datapath.h
@@ -13,6 +13,7 @@
 #include <linux/skbuff.h>
 #include <linux/u64_stats_sync.h>
 #include <net/ip_tunnels.h>
+#include <net/mpls.h>
=20
 #include "conntrack.h"
 #include "flow.h"
@@ -173,6 +174,20 @@ struct ovs_net {
 	bool xt_label;
 };
=20
+#define MAX_L2_LEN	(VLAN_ETH_HLEN + 3 * MPLS_HLEN)
+struct ovs_frag_data {
+	unsigned long dst;
+	struct vport *vport;
+	struct ovs_skb_cb cb;
+	__be16 inner_protocol;
+	u16 network_offset;	/* valid only for MPLS */
+	u16 vlan_tci;
+	__be16 vlan_proto;
+	unsigned int l2_len;
+	u8 mac_proto;
+	u8 l2_data[MAX_L2_LEN];
+};
+
 struct deferred_action {
 	struct sk_buff *skb;
 	const struct nlattr *actions;
@@ -200,6 +215,7 @@ struct action_flow_keys {
 struct ovs_pcpu_storage {
 	struct action_fifo action_fifos;
 	struct action_flow_keys flow_keys;
+	struct ovs_frag_data frag_data;
 	int exec_level;
 	struct task_struct *owner;
 	local_lock_t bh_lock;
--=20
2.49.0

