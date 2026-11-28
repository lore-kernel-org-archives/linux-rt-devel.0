Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795862030;
	b=YT5D28bAER/rTz/WjGVyk2Du1HrQKIzuPWChLkRJMEjV7WO/q5iFlrLMGWuDGu0qaJdr
	 bmgCjgdu7i6W81j2t5VLxHIK3Vy9Le457SJg8SrtjYxpBZfHJ1L2RNsrQKfW6fDzU6Kpk
	 WCgNbx+eTkvbIRebkVjhZrOrnaazDU6fSyvTn5xrG0KxT0iL2pfsclvk/60pvArcxWhlb
	 tYarfZIuAN1rsf0WQvr5qECB73Cu5BzsVczYBBzQNOLrC1e3aRpZZtspvlsiH+q9VhYBt
	 UElZG7/sJi3klmP7nQBxoXgNT0ySibf2KVFytDQCTVO9HVBzlYunR8XtL4JB68jT+qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795862030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
	b=0yTyH2JhK2aim+F4uEFY0yx3V5N+JNmntVMwztuPPDcv8nEbCUm/f15dDYkcEV/2rJUj
	 r8IvIANPn0FaSjSggQLHV/OlzlRYSK4Af3S50aS9MKW8Hvu4sHD2xAK+SfFtswxxfsrfX
	 2tio7xhN+51wPMTYcHlg00BGv5VzV8cEFovwKGBO6mM2UBb72u/nu8u/5C+DGsRaheQ8C
	 iE+XuXe0t97zTSAMYcR5KbMZv55Ie6pNmVJ+8+BYLG4t0Ufjw7dSd6COUW9IocmPDMBck
	 /GiZK25h5AzOik+wADzSb2AuyUcMjqowwW+uEItvfdYaVN9fDsMSVG9GsKMRKB2h23A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mtJSQ1My;
	arc=none smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7D606A31C
	for <linux-rt-devel@lists.linux.dev>; Sat, 28 Nov 2026 10:33:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3A7D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=mtJSQ1My
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-55d03bfd477so99934981cf.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 28 Nov 2026 02:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795862028; x=1796466828; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
        b=mtJSQ1Myh6G9o89Z2P1kzAqYAvazkBi0x7YZK8YSEqWmKX8vjnnG1WPVmfYV33drSo
         kN7ZQY9Xn5JvO3oV5CtSlQjtz6rc2yDh187p9Pq9Xq5pRRxEVdh34nghx929hUIgyLyN
         20Ibzb6E8fY3fd8PN+TGhmm/FvJv5mbO/BnhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795862028; x=1796466828;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AHvYKHq95D+qAXx/ZpNwF1YDR0GRXaHoHUy1ieoCmCI=;
        b=Nmm+CeUmQ8UJKexLuGWQVUxcFL3Ml5vXMj/VGOvwyBeuqjpnjshb7TGppyY8VlFrUt
         Zaga8x3a+0UA3Za99EGPVcysAuGn6c+6u/CzEj1V7TLYDVx/O1yk0g2scfeXP2EjzdRw
         +h7rPcXls/X68DrYxKHmB0+FyFtjopej6XjPip1f4CqNIdLrWR8yYb6IPuBcbwZ3pzOV
         8X2RlfsMRhyzgwn5GiGxyy516OZFCCt5wARJ8PH4NnFZ22w7xHBFS3xI+JSKfbucc+iO
         BRj+1UfVU3D4ApObJW2m0wfqyuTejGXFJHA4ws3zCSNSc7bKxyjDJI5AJGULRak1kxsJ
         GiYg==
X-Forwarded-Encrypted: i=1; AL+hErG/+ypF/M7lGGeynX+ZG8ej0yMtApOqFCKIFncZwx8s4qsFyRz8BTXYD8yPobvXxd5X+HnJOCCtYr9B55OCGg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8sMCIRYm7VcQxfcov/FnFSPSxa7nOxq94jtAQX7km9K5YARhcN
	pmgjh8QELecS8yE1cMAxrD/vNXcX8xT2bsWyam8OiP5t+pflLFwghnmbAJhsnwkjiA==
X-Gm-Gg: AZFdTZc4OUmP3Izq8CjU0Rftigk/09PMl/LUXfsGIAcr3eKPTh4ZRxhSSyhSdzJBDpq
	ynP5OxDGN7yAShLqbiDgLILTWWBbQeebP6JtoPs+j2LIhqcjs30jG1BjCU/ja3JNrO4AmSVeXdz
	k2020Jnwj00ObeO45ZXZ/erf331XsWQQHO2CqBhJd7+/O6dNAqOZNrrSEQDpnrN4U1+Feb7qcrx
	j2weOdNznbRnM2Ubi6V77PYxk81RGFfS9xj31pt3tHKPyMENEQ44eB2wHd2RExf1e0bvPFj3h7B
	2MEGvbeVRNGBMPdCTR5iIN7dvcSYvCGv4xgRLho6nyvgeZaBVHKxWQIfESYuNb8H/8uuYYuW83/
	yrFC3D+jryvckhmu+6VsYnNrADGXc5ALQ98rh8GnMPko7DiwBSowbbTZ93lpCsM73nHi6ENn+pb
	03a8kepHAjlkDpfNKkICFPbOWe99AV+OMaO43+guNOeTFFd93vhahqZc2GiW+lNjmaVPCvj3GL4
	j/ltN072uJyN3fw0t/FgIREL+06AnnUXGSudj6dKoZEkxSKv5ezQx93Rykp2oLZxD51u10s7/MF
	kGeFSRJzt6OD0F914JBejP0iMyAb6bXmbclU8x56CrD1Eq2sNug2NNvT7U9M1Pvah5JuEgjHOh0
	0zsIq
X-Received: by 2002:a05:620a:3722:b0:949:472f:226e with SMTP id af79cd13be357-949bab15455mr5419372385a.71.1795862027745;
        Sat, 28 Nov 2026 02:33:47 -0800 (PST)
Received: from majuu.waya ([184.147.180.207])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3f5c31sm2053970085a.30.2026.11.28.02.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 02:33:47 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	wenxu <wenxu@ucloud.cn>,
	stable@vger.kernel.org,
	Victor Nogueira <victor@mojatatu.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH net] net/sched: sch_frag: guard against same-CPU re-entrancy
Date: Sat, 28 Nov 2026 05:33:33 -0500
Message-Id: <QDISC-R0QC.v1.r0.20261125082538-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a followup of commit 975b5b067f52 ("ipv6: sr: restore network
header before routing and forwarding") as reported by Sashiko. That change
fixed the negative L2 length that could reach sch_fragment(); this patch
addresses a separate pre-existing bug in the same fragment path.

The issue:
sch_fragment() holds the per-CPU local_lock_nested_bh across
ip_do_fragment()/ip6_fragment(). Their sch_frag_xmit() callback calls
data->xmit(skb), which may re-enter TC egress (cascaded act_mirred
redirect to a qdisc that calls sch_frag_xmit_hook() again on the same
CPU). Re-entering re-acquires the per-CPU bh_lock:

- on PREEMPT_RT this is a real spin_lock, so the same-CPU recursion
  self-deadlocks;
- on non-RT the inner call overwrites the shared per-CPU sch_frag_data
  (dst, cb, xmit, l2_data), so when the outer fragment loop resumes it
  uses the inner call's stale state.

With the lockdep detector built in, the recursion reports itself as:

 ============================================
 WARNING: possible recursive locking detected
 7.3.0-rc7+ #44 Not tainted
 --------------------------------------------
 python3/20084 is trying to acquire lock:
 ffff8e80bd7b44d0 (bh_lock#2){+.-.}-{3:3}, at: sch_fragment+0x288/0x560

                but task is already holding lock:
 ffff8e80bd7b44d0 (bh_lock#2){+.-.}-{3:3}, at: sch_fragment+0x288/0x560

  Possible unsafe locking scenario:

        CPU0
        ----
   lock(bh_lock#2);
   lock(bh_lock#2);

                 *** DEADLOCK ***

 Call Trace:
  <IRQ>
  sch_fragment+0x291/0x560
  sch_frag_xmit_hook+0x74/0x90
  tcf_dev_queue_xmit+0x1f/0x30
  tcf_mirred_to_dev+0x2da/0x560
  ...
  sch_frag_xmit+0x169/0x260
  ip6_fragment+0x8dc/0xa70
  sch_fragment+0x33f/0x560
  sch_frag_xmit_hook+0x74/0x90

The Fix:
Prevent same-CPU re-entrancy by recording which task owns the per-CPU
fragment state. A deeper call must not re-use the outer call's per-CPU
state, and it must not transmit the skb: sch_frag_xmit_hook() has
already determined that the skb exceeds its recorded fragment MRU. Drop
it and return an error instead.

Owner identity, not nesting depth: on PREEMPT_RT a second task that
reaches sch_fragment() on the same CPU waits for the real spin_lock and
then works on its own state, so only the task that already owns the
state is the recursive one. A depth counter would refuse that contender
too, and reporting -ELOOP for it would be wrong.

Conditions to recreate the bug:
  # Minimum privilege: CAP_NET_ADMIN in a user-owned network namespace,
  #   e.g. via `unshare -Urn`; nothing outside that namespace is required.
  # Build with CONFIG_DEBUG_LOCK_ALLOC=y for the recursive-lock splat;
  # on PREEMPT_RT the same recursion is a hard self-deadlock instead.
  ip link add vetha type veth peer name vethb
  ip link add vethc type veth peer name vethd
  ip link add vethe type veth peer name vethf
  for i in a b c d e f; do ip link set veth$i up; done

  # outer: reassemble the fragments on ingress, then redirect to vethc
  tc qdisc add dev vetha clsact
  tc filter add dev vetha ingress matchall action ct zone 1 \
      action mirred egress redirect dev vethc

  # inner: the refragmented egress re-enters sch_fragment() on the same
  # CPU while the outer call still holds the per-CPU lock
  tc qdisc add dev vethc clsact
  tc filter add dev vethc egress matchall action ct zone 2 \
      action mirred egress redirect dev vethe

  # then send a multi-fragment IPv6/UDP datagram out vethb (the zone-1
  #   ct reassembly sets cb.mru so the redirect enters sch_fragment()).

Fixes: 20d677d389e7 ("net/sched: Use nested-BH locking for sch_frag_data_storage")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260827092345.2301937-1-fouriezhang@tencent.com
Link: https://lore.kernel.org/netdev/20260827092345.2301937-1-fouriezhang@tencent.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_frag.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index 75ee52750919..980f1490b027 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -17,6 +17,7 @@ struct sch_frag_data {
 	unsigned int l2_len;
 	u8 l2_data[VLAN_ETH_HLEN];
 	int (*xmit)(struct sk_buff *skb);
+	struct task_struct *owner;
 	local_lock_t bh_lock;
 };
 
@@ -98,10 +99,19 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 
 	if (skb_protocol(skb, true) == htons(ETH_P_IP)) {
 		struct rtable sch_frag_rt = { 0 };
+		struct sch_frag_data *data;
 		unsigned long orig_dst;
 
+		data = this_cpu_ptr(&sch_frag_data_storage);
+		if (READ_ONCE(data->owner) == current) {
+			kfree_skb(skb);
+			return -ELOOP;
+		}
+
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
+		data = this_cpu_ptr(&sch_frag_data_storage);
 		sch_frag_prepare_frag(skb, xmit);
+		WRITE_ONCE(data->owner, current);
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
@@ -111,14 +121,24 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		IPCB(skb)->frag_max_size = mru;
 
 		ret = ip_do_fragment(net, skb->sk, skb, sch_frag_xmit);
+		WRITE_ONCE(data->owner, NULL);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else if (skb_protocol(skb, true) == htons(ETH_P_IPV6)) {
-		unsigned long orig_dst;
 		struct rt6_info sch_frag_rt;
+		struct sch_frag_data *data;
+		unsigned long orig_dst;
+
+		data = this_cpu_ptr(&sch_frag_data_storage);
+		if (READ_ONCE(data->owner) == current) {
+			kfree_skb(skb);
+			return -ELOOP;
+		}
 
 		local_lock_nested_bh(&sch_frag_data_storage.bh_lock);
+		data = this_cpu_ptr(&sch_frag_data_storage);
 		sch_frag_prepare_frag(skb, xmit);
+		WRITE_ONCE(data->owner, current);
 		memset(&sch_frag_rt, 0, sizeof(sch_frag_rt));
 		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
@@ -129,6 +149,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		IP6CB(skb)->frag_max_size = mru;
 
 		ret = ip6_fragment(net, skb->sk, skb, sch_frag_xmit);
+		WRITE_ONCE(data->owner, NULL);
 		local_unlock_nested_bh(&sch_frag_data_storage.bh_lock);
 		refdst_drop(orig_dst);
 	} else {
-- 
2.43.0

