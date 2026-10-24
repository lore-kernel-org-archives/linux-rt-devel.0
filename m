Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848678;
	b=CZ4FdcqltU7rN8xAbt7HsjMLuWFWkzZpsTmkYbqooa5vXsXSTtwaMeq8wB11WslJNZmF
	 1xnO/Lwr4z+XPqvMDSx+AXxvR3TkB1nWGm76LK5iY4LojsIbdEnssdSu+tw+mLtV6XvNe
	 EVUpefru/HkMe6aaVBOlHgMG9gmFJLiDx4RaJqInG95cPZds9nLjoE7+3Ygii2aEDbYLA
	 igw67OnEHstjZ8E6WoNB7belB3oVmKTqwXr+OwBeAlhvn7Ooof6XgEv/nPHWKZsK4pawS
	 qi90/xbeT/m4ONKbASMtyicdH9ezzBIqP9AS18TTZQk5oWoLDqfiRYFgw+ex6SzFm5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848678;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pLRCk8/9dz1C4nPJOhz+7qY3xmEsmaSdUyTaRo4R8tM=;
	b=jqhwJKBUqZJDn81Ie+w5vurpegJ6ayg3Scq24V9EnadjRC4xrJE9DXkTYazHTfTAM3kv
	 I2Nub5DFtwxe0/4glIKAyIdNILqGRam5Gk2OP3uaZV5Xo0rYe8rzl2p8gwQ+wDDfbmvYM
	 jdM6a+WgUPe3ryDQdF6Le0iL8dUt1vhLIpWUt2DBv1bQpRAeZ+XT4QBYORc9qhbZBKZm2
	 vL/0a4lVzpCH2kJ0lDrY/BG0DOqAK+YQHQ0Rg8rud8N51zhKfga6B9b4+6oxMXpHOTPal
	 JaY+UXEq8OKldl2DRCovMo19sMzF8e8H59pBny+fLDzrnDHuBxtuRWWNSXlJlJ+O/qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RpzB5zab;
	arc=none smtp.remote-ip=91.218.175.43
Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58CA606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D58CA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=RpzB5zab
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=B3jMk3eCeC8Y3GqSv15e2NLDsK4khOcl+UEkO6mDNtQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848676; v=1; x=1793453476;
 b=RpzB5zabT2GyV+Qsunn8BOagnAuhd3QNYnZoeT4asR2Jt7m48sBz7+KJJF075bGb14gv9Bkv
 4We3sA+hRcizjlwZqf6qgqQdNSg2DQ4am2nM4VoqOPQUM8RRpCQt3zPQJIVKCkvpxOAAv1eNcz2
 /8ez8LntuQvdixHTw+RV8hVk=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id a50a7be961c9d0a1;
	Sat, 24 Oct 2026 13:31:15 +0000
X-Mizu-Trace-ID: a50a7be961c9d0a1
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 07/15] net: add debugging checks in skb_attempt_defer_free()
Date: Sat, 24 Oct 2026 21:30:31 +0800
Message-Id: <6f4c4e5f1aee6299dcb20c98ee5e86011a555954.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
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

From: Eric Dumazet <edumazet@google.com>

commit e8e1ce8454c9cc8ad2e4422bef346428e52455e3 upstream.

Make sure skbs that are stored in softnet_data.defer_list
do not have a dst attached.

Also make sure the the skb was orphaned.

Link: https://lore.kernel.org/netdev/CANn89iJuEVe72bPmEftyEJHLzzN=QNR2yueFjTxYXCEpS5S8HQ@mail.gmail.com/T/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/skbuff.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index a66066bc9861..919ad5a2c5da 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6727,6 +6727,9 @@ nodefer:	__kfree_skb(skb);
 		return;
 	}
 
+	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
+	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
+
 	sd = &per_cpu(softnet_data, cpu);
 	defer_max = READ_ONCE(sysctl_skb_defer_max);
 	if (READ_ONCE(sd->defer_count) >= defer_max)
-- 
2.25.1

