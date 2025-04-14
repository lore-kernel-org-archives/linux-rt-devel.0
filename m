Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562B727A106
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Apr 2025 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744646894; cv=none; b=sq8Et84UuRtjUWXGL3PITUFfR0dFf2yIQLptJd3VnfUHufkKVMuuj8b3DIJII5cTPXOFPnR3/nbwN7FE+d74ldqrMI7HQ+c2Bfe1bMirw6KwqayAy7ZqFb5xTneJfWvLEGxrg8ODmKVDCosfsWort26ys5CeoQXEHmqsbqoOTts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744646894; c=relaxed/simple;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqCBCCMz/+LE5SxfH4+KELrqag4uvy0dNSAPEFKObPawC7mZktDy4tsF4XNrd0cN6X2vOMgver9oP7JaEpkdmKDKEj2k8v66ZlvbGIB25hSLplW/8zjhKTjP+irmlQiv8W2cM/JHRWkIavVO4MUfBbXZ33lACPI2yRwfAik0x/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41qeC1Ys; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zLWPFAKa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41qeC1Ys";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zLWPFAKa"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=41qeC1YsGkAN3auxDMHD19W5/uGEf/Ua9hBZtbSuJFX5MQvCdsOodLA594sE1Ct6ilSHTU
	kMrFZAgU9QcAddSxeARSRdZDuInTtgFm6AgRdcbphcq6Np3r+frR+I7aGs02I1vd06x0nI
	D7Y2k7MwI27SjWnGHZcG+7BJ7RZ5fLKAG3XUgGNQjtaNQzFE1n84IfIIZe6ezlrKuZYCyC
	gmmNwFGEaHUBctT+y2Dwvm2Cyab4vRiQbKVhFnX9sv2gMWukjcO9DWkyNqhOstJox/weuC
	LZW2EEgq3ZXoRSSzcAR1rnrFI7rgDlAwwKE1TAmUrnPa3qVPRoDF6JG7L34FiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744646889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XzP37hO56c2xQS5lfFRi7CcXZKqGOwxBFRkTdKRLe1w=;
	b=zLWPFAKaXIfNhq6AnLBBg9uj3eE0nC+66wA2b/NDpEU4xM0wBF0/AI1JbsKwvh4l4K1JEM
	KLZ4Uw1Qa6KA7cDQ==
To: netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH net-next v2 03/18] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Mon, 14 Apr 2025 18:07:39 +0200
Message-ID: <20250414160754.503321-4-bigeasy@linutronix.de>
In-Reply-To: <20250414160754.503321-1-bigeasy@linutronix.de>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The statistics are incremented with raw_cpu_inc() assuming it always
happens with bottom half disabled. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this is no longer true.

Use this_cpu_inc() on PREEMPT_RT for the increment to not worry about
preemption.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 753704f75b2c6..5d7c7efea66cc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -189,7 +189,11 @@ const __u8 ip_tos2prio[16] =3D {
 EXPORT_SYMBOL(ip_tos2prio);
=20
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
=20
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
--=20
2.49.0

