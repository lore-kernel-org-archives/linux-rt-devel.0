Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012580;
	b=zEa/s6sgPtXOXt+7zsGsUWDp1qh3xQo5ZN/4gUgWY31yfX54EjMr0hZElTTZdzMvZHAv
	 lTBfGUruHJLJLGxB47wjGvp9A1R985sn20LYFq1Klpzefb5+4qF/VXxRgNdWXA5oWAAed
	 mHJa+Km4cKmzKtKgDjZ2r7oMZvnPMWNNZ4LTavryXLaFbNSoRTwuEwGgAkVYbQpKm7FGm
	 ZHIjVz577YZzmPiFyFUmx8JVAXjCZW9Q4J5BXD55V6RVShAgPpgC98QqYTF9BNKQ7r2BH
	 GJaQqlVz4gtSuyYHqjThgm8Ss9P55SopqN7Tcwgxhnklwoj7/pL3/6P7xdWX8PKF5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eUvQo6CtcCYbofMdXDXNFTy9F7Un1CTJJFERs6q6wl8=;
	b=oN9LctJh4y8HFoqXbKkZXlJO2MIopulGJPaI1HMrD12hk6rZWnJeicwyh3B9QSk7c4Mf
	 jlAdWmFGamsNI9o2XLnrAKuIjZGwOuHH218KFQF/N1GZR00r5ONKDDhjfvDrcqtFr6x5t
	 NGQEd5PyhBpg1l68g99Pt+FOOtihOgk6ev6uYXexp9FxTydeeNcobUYAxCoxAyzIsHrgu
	 k6OmDtZf/vZgP/CuzezS18YHX+Kxw/YypZia0/xydIMoQD5xX9DHwOcKuDCAhK4TKPGdl
	 WO3h/LoRqoo3mfJU9AXTZm7vrGDHWRq0qfFom+UtA4/y0gendA8kO76/CFwnzxqmsNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=VffRk9wz;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069D606A33D
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C069D606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=VffRk9wz
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36fb88ea38cso231470eec.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012579; x=1794617379; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eUvQo6CtcCYbofMdXDXNFTy9F7Un1CTJJFERs6q6wl8=;
        b=VffRk9wzq7q6mC95focVfhvBz40HJIYO6AXTcPo3ALRTTQYkwsn2eIUw4u9BlxO+ip
         vHsHMXvrXkFXAkPvu6Ik2E7sM4DdDUy7X9/OQDEOfRV5ISlFd9kEnLQ8X/QJLoDXeLrt
         KEIhMN6L5JtPPwADGrRAHxS6rUSZt7NbpgFYiyaVKjuY+4oAJIb+NCc1evvprnfs9ryU
         LEaXY8HhpHOjcZ/iyiCKbAGY66+lfY061al+ywUYDT2Cmd8lqOqpt+8CQ254DrMSZ05Y
         bp16tItlEkvMzZD0rx0GxF6T7DLX0JQpaTFgS4cy4+5hcRe6eRlOlzc8CGCG0Il81DNx
         kzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012579; x=1794617379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eUvQo6CtcCYbofMdXDXNFTy9F7Un1CTJJFERs6q6wl8=;
        b=1X/tpw5NTS4oiUuzPVlGfwFM0moUTq0xfUvtymWX4ORQzpuUbGPDdSQJ9xnhKuazh9
         3AiZjvZaKdKS2/6DYInqsSDQdPapuWtv15KI0017Xzvz8aIEXMszLumHNHJIvtx7iLop
         OPW5pLSzpZYjB/iSBG6uEANSGoyTOffkugvttMsiI3tk5yql/y+Vpojm8uTked9Oizvb
         FQMfY6W5A6eoz9igPDjUbZVQS5bf/ClrUlgXDz+s+LFdksNhwUvfq+yo1jAg4T1w0p3i
         ia1KPqyuojH0d8gK5ndQpEoscJEAGGgH80OEaWU8RuXtxkBWDUsNI1IbmTKSeG/KYa+m
         5yEg==
X-Forwarded-Encrypted: i=1; AKwUvBwVqDiThg69wom96RYQ0oLnq4qVXfvGxJTqVmVnTAMjjYZo9CYKdssbMrpmeTLfbdQ6Kse62hnzAI1lRs0KAA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9n0dR9S+1VvQY9kbNPREDcECk5FqvhA2SGvhB+8gQg6gmL5Xf2
	HLdB5GQgqKyclWz47xkKn5A4UhKKuReEH6h0KmVrYcaAJV68IRzObjWzYoIkjtLzqk4=
X-Gm-Gg: AYBFou0BIkYUR7DoZur6Zaxk7kJL4jP3aSQDixwU76DOEYH4PKTD/Ul3AQ6aLmvG7LR
	DV+1xer9zGyKu1W1zyQIlutmZfJ6FHN7aWHkiPicfaIz1ybzelASCs+Fx/ObGs93wTLkdO9dBFg
	dHCpOIWnxOchDkdpItzrebgQg8LZInGKH+/0aD0lCMMxRAdSgzvNw8ZNl/9WkNqgwzOSaxKwidi
	2zTTzqRkq+AXRFL9oTAT5Fd3NqNRjczdHIEGjLYXA7ty3+N41BG/ZsSt4Ac0SoU9oVHAHTfRDGN
	47mjlfker4l0LIuvq9JfSoO24TalSQhrTdtpti1foL60+ueWq8xgV+6SRphFw1eCMrfUbnQsbTn
	k4vvRxyRZz6o950ImejYkp7Rl/ncxcN0nlQlpOl4kBOa/XnqhOZrcAtN6WvoJWvQPvO+iguuwyR
	AZSXOqsidMOnVvUYEU/QgmqtR7dXCiaKAiQn4HcMApnAXuRSbypmFKrq2wH+QthlU5nF2lVZ+BC
	KKw0yAhpCg+f3CuRN1OKNZ2pjZR5Cby4uXckp9JUs1Kx12e4dfICq1Zg7cBs2H93e56oYtarRYE
	JkVzwB5EeLGVw1LEBWk/cOARLQN5sn/UA2E/1+v4PgcTu+fPw3SpMKRpMQJzhfAvq2Hq06o=
X-Received: by 2002:a05:701b:4591:10b0:1b2:46ee:4cba with SMTP id a92af1059eb24-1b269b2154dmr765522c88.18.1794012578472;
        Fri, 06 Nov 2026 16:49:38 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:37 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v6 0/6] amt: relay tunnel lifetime, validation and request-path hardening
Date: Sat,  7 Nov 2026 00:49:29 +0000
Message-ID: <20261107004935.2627329-1-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
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

This series hardens AMT relay tunnel lifetime, validates gateway input, and
keeps unauthenticated Requests from consuming relay state. The problems
fixed by patches 3 and 4, and the pre-Query drop in patch 5, were found
during the AMT IPv6 outer transport work, which is not included here.

I am using the existing IPv4 AMT relay and gateway implementation in a
multicast delivery network, where gateways on access networks send IGMP/MLD
membership state through a relay to reach downstream receivers.

The first patch detaches the receive path before amt_dev_stop() tears down
events and tunnels, so no receive-path reader can queue work after the
teardown. The second closes the gc_wq re-arm use-after-free and makes
teardown safe for RCU readers and delayed group/source workers. The third
rejects Queries and Data from 0.0.0.0 before relay discovery and
revalidates deferred Queries. The fourth requires exactly four bytes for
IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP. The fifth makes pre-Query
drops visible, avoids counting successful reports as drops, and uses
concurrent-safe TX statistics. The sixth keeps Requests stateless,
authenticates Membership Updates and checks their IGMP/MLD message before
allocation, keys state by address and port, bounds per-source admission,
and silently drops failed endpoint admission.

Each commit message says how its problems were found. The problem in
patch 4 was triggered while writing an IPv6 selftest; the others were
found by review or code inspection.

Changes in v6 (patches 2-6 were v5's 1-5):
- New patch 1: clear the socket's sk_user_data before amt_dev_stop()'s
  grace period, so no amt_rcv() can still queue event_wq or link a
  tunnel after the teardown. Found by code inspection while reviewing
  the changes below.
- Patch 2: run the deferred group/source GC directly instead of
  flushing its work. flush_delayed_work() queues the work and waits for
  it to run, which needs a free amt_wq active slot, so
  amt_tunnel_expire() and the group GC, both amt_wq work, could deadlock
  once every slot was held by such a waiter. amt_dev_stop() calls the
  GC the same way. (Sashiko)
- Patch 2: amt_tunnel_expire() reads jiffies once (Sashiko), and reads
  last_seen and marks the tunnel dead in one tunnel->lock section. The
  Update path refreshes last_seen under that lock, once the encapsulated
  message has passed its IGMP/MLD check, so an Update either keeps the
  tunnel alive or finds it dead (Sashiko, raised on v5 5/5). An Update
  never stores 0, which marks a tunnel no Update has refreshed.
- Patch 2: keep amt_group_work()'s loop braces, and order the
  declarations the patch touches longest first.
- Patch 6: create or refresh tunnel state only once ip_mc_check_igmp()
  or ipv6_mc_check_mld() has accepted the encapsulated message.
  (Sashiko)
- Patch 6: the tunnel lookup skips dead tunnels and amt_update_tunnel()
  retries once, so an Update that races amt_tunnel_expire() creates the
  replacement instead of being dropped. (Sashiko)
- Patch 6: the Request path's per-source count skips dead tunnels too,
  so a tunnel being expired no longer withholds a new endpoint's Query.
- Patch 6: drop the per-Update amt_update_relay_status() call, a no-op
  since tunnel creation sets that status (Sashiko), and the last_seen 0
  special case, since every tunnel is now stamped when it is created.
- Patch 6: retitled from "amt: harden relay authentication and
  teardown"; its teardown changes moved to patch 2 in an earlier
  revision. Its message now says why a refused Request gets no ICMP Host
  Unreachable.
- Patches 2, 3, 5 and 6: correct commit-message and comment claims that
  overstated or misdescribed the code, and say how each problem was
  found without per-version history. Patch 4 is unchanged.

Changes in v5 (since the 2026-10-20 posting; v5 numbering, so its
patches 1-5 are v6's 2-6):
- Patch 1: flush the deferred group/source GC with flush_delayed_work()
  instead of cancel_delayed_work_sync(). Both GC works re-arm only
  themselves, so cancelling them on tunnel expiry or device stop stopped
  periodic GC for good after the first expiry. The flush only reclaims
  promptly; lifetime rests on RCU and the cleared owner pointers, and the
  comment and changelog now say so.
- Patch 1: clear snode->gnode and gnode->tunnel_list with WRITE_ONCE().
  Neither pointer is __rcu, so RCU_INIT_POINTER() drew two new sparse
  errors.
- Patch 1: keep amt_group_work()'s single out: exit and move
  rcu_read_unlock() below the label, instead of open-coding
  rcu_read_unlock() and dev_put() at three exits. Every exit still
  drops RCU and then the timer's device reference.
- Patch 5: drop the paragraph about tunnel liveness checks, which moved
  to patch 1 in the previous revision, and fix one continuation-line
  alignment.
- Patch 5: copy the secret generations in the Update path under a
  seqcount, amt->key_seq, rather than under amt->lock, as the Sashiko
  AI review of the 2026-10-15 posting suggested. Forged Updates now
  take amt->lock only on PREEMPT_RT, to wait for a writer. Requests
  still read key[0], nr_tunnels and max_tunnels in one O(1) amt->lock
  section.
- Patch 5: say in the commit message why one address may hold at most
  16 tunnels.
- All: state how each issue was found, and put Signed-off-by above the
  "---" separator (it was below it in the previous posting, so git am
  dropped it).

Testing: on base-commit below, each patch builds without new warnings
with W=1 C=1 (sparse) for IPv6=y, IPv6=n, PROVE_LOCKING and
PREEMPT_RT. With KASAN and lockdep enabled,
tools/testing/selftests/net/amt.sh passes (6/6) with no splats.

v5: https://lore.kernel.org/netdev/20261105125010.1107546-1-omar@blockcast.net/
v4 (mislabelled, 2026-10-20): https://lore.kernel.org/netdev/20261020002557.3984927-1-omar@blockcast.net/
v4 (re-posted 2026-10-15): https://lore.kernel.org/netdev/20261015220648.1545576-1-omar@blockcast.net/
v4: https://lore.kernel.org/netdev/20261013175407.947606-1-omar@blockcast.net/
v3: https://lore.kernel.org/netdev/20261012125943.558629-1-omar@blockcast.net/
v2: https://lore.kernel.org/netdev/20261009201455.1904698-1-omar@blockcast.net/
v1: https://lore.kernel.org/netdev/20261008003606.3666617-1-omar@blockcast.net/

Assisted-by: LLM

Omar Ramadan (6):
  amt: stop receiving before amt_dev_stop() tears down its state
  amt: fix use-after-free when a Membership Update re-arms a freed
    tunnel
  amt: reject a gateway Query or Data from 0.0.0.0 before a relay is
    learned
  amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
  amt: make pre-query report drops visible
  amt: create relay tunnels only from authenticated Updates

 drivers/net/amt.c | 623 +++++++++++++++++++++++++++++++++++-----------
 include/net/amt.h |  31 ++-
 2 files changed, 504 insertions(+), 150 deletions(-)


base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
-- 
2.43.0

