Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588F11DEFE4
	for <linux-rt-devel@lists.linux.dev>; Sun,  9 Mar 2025 14:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741531636; cv=none; b=Hq0i3MEAvLDYXX/7ToeQQkfZMVIOHNKqAbvMdT7Yt+sFgcRX9Ftc/sTnTGNI4tuZHq9NsUto1CNfCnMs+dyqsPHkg2BIPU2FxqSrdaMTpGw6o/HaTIJUQvZxd7/JjJndbC1HU3iYXsZs4FqyGhEtKPwyLSadgj/Qq9f1AVyna0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741531636; c=relaxed/simple;
	bh=JVXWocJGEIMRFtTQthOdRIIFNkOg/kxXdes6qPDQQmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNMoY/1a4F0laksSzSmTF8TYBvhwd20Diqj5A6Jn86e26fqN3czFxj4+4e7uaH8TcviF8BhxmPdBnMAFVzkLRdcwgTBp2F2NFx1paccCt21UOYhcwUTED7QfFCr/eBh3y7Evsj8YIvVEKTm6iet98sXZ4C67e8q6r+AjTsLkq9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CeAulmQf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0qI01tL4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CeAulmQf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0qI01tL4"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/O19zGNMWkbRQbv7Ue1v+gdizHBBILcxT+WkkdT9yI=;
	b=CeAulmQfapeqE7tR2O7NkBNXI8/B75iIUrZ7qPkb7j29rtMuvcjDz3rGpm0MB13VXIddbL
	1EdQKLXFLr1hLMrb0lWCaiBJvZ8hn9fX0QJtOwDaa2Eql8/VCSJopDWuYVVO1eZnRZFaq3
	Ynak4rR4h+JCA9wv0rYxuiYGwU3PhqIVPMhxyjSOmLeOrTYZ8wGNIuu8WePvx4TcfYkLyA
	StWlsgAYdFy0jtJhnTsx6+QPxKI+/dgWnuVBPmr7NTQ/40QYhY/Zm2v3t91yg86WQT8wgm
	aZwUB2ImOrvUji01x/VF2c+pnNILwpSsmzU6liqIRyeRFReRp6J1tgr6p1N+Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741531630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U/O19zGNMWkbRQbv7Ue1v+gdizHBBILcxT+WkkdT9yI=;
	b=0qI01tL4zlLWYIIY3ddjN4wrDrJ121oZs4QU9AL0Dp+gV7AkfL02wMNPU5IrsmFkdjEF2Q
	0iPL+xInMSl9g0Aw==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next 12/18] openvswitch: Move ovs_frag_data_storage into the struct ovs_action.
Date: Sun,  9 Mar 2025 15:46:47 +0100
Message-ID: <20250309144653.825351-13-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-1-bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
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

Move ovs_frag_data_storage into the struct ovs_action which already
provides locking for the structure.

Cc: Pravin B Shelar <pshelar@ovn.org>
Cc: dev@openvswitch.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/openvswitch/actions.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index c4131e04c1284..3ced7d8a946c2 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -62,8 +62,6 @@ struct ovs_frag_data {
 	u8 l2_data[MAX_L2_LEN];
 };
=20
-static DEFINE_PER_CPU(struct ovs_frag_data, ovs_frag_data_storage);
-
 #define DEFERRED_ACTION_FIFO_SIZE 10
 #define OVS_RECURSION_LIMIT 5
 #define OVS_DEFERRED_ACTION_THRESHOLD (OVS_RECURSION_LIMIT - 2)
@@ -81,6 +79,7 @@ struct action_flow_keys {
 struct ovs_action {
 	struct action_fifo action_fifos;
 	struct action_flow_keys flow_keys;
+	struct ovs_frag_data ovs_frag_data_storage;
 	int exec_level;
 	struct task_struct *owner;
 	local_lock_t bh_lock;
@@ -800,7 +799,7 @@ static int set_sctp(struct sk_buff *skb, struct sw_flow=
_key *flow_key,
 static int ovs_vport_output(struct net *net, struct sock *sk,
 			    struct sk_buff *skb)
 {
-	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	struct ovs_frag_data *data =3D this_cpu_ptr(&ovs_actions.ovs_frag_data_st=
orage);
 	struct vport *vport =3D data->vport;
=20
 	if (skb_cow_head(skb, data->l2_len) < 0) {
@@ -852,7 +851,7 @@ static void prepare_frag(struct vport *vport, struct sk=
_buff *skb,
 	unsigned int hlen =3D skb_network_offset(skb);
 	struct ovs_frag_data *data;
=20
-	data =3D this_cpu_ptr(&ovs_frag_data_storage);
+	data =3D this_cpu_ptr(&ovs_actions.ovs_frag_data_storage);
 	data->dst =3D skb->_skb_refdst;
 	data->vport =3D vport;
 	data->cb =3D *OVS_CB(skb);
--=20
2.47.2

