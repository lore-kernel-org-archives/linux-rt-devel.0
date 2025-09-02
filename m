Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929431E11F
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823808; cv=none; b=ueSf4d8dWqIvgYR4YUNP9t9SpS14Mb2VfLtfGMDROzOZ7qdOLWcwPzAWFb6pRxGlFH0z43Fk1Nl+M6Wgz1NLPw5ZhtpCJrzIg/b9eYUU2xB7Uk0DHLyR6Jaw/b2+PD5D5ZMVHrL4i/34/BN7QHONo+W8pnKcNR7CE1NOD4WYb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823808; c=relaxed/simple;
	bh=uv+sRDVE9UdYp/rrXBaRI2PRNEO+AlIgCJajD1luaOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qxNAvNXSJ1Wow+7zJs9f9PAvqrO11B3CRAYl+Ho6p6MhbbnQ2ui81lPX3Aq/R6B9It0O1e43eY+9k+UQZZuCmqxBhfAab9aBe9Aj/kv+ZbZqVbBX7pBhdq8+7Y8JGza6kcfs+gTzXG7PXp1zNoZzPFMoK9ENkPQ9VkJxX4qIaAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61ebe5204c2so1087041a12.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 07:36:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823805; x=1757428605;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ixDvZ/+7M4TDPK7mHzqbLvaRWPSa4oHJo2q4oJdkek=;
        b=PXzmYhapgUBmFls/sNxi/1UqWVpWGsfbW2uj5kt1VycYkgD9R7C6Qo+CK+hKFqr+jU
         nXV0YOyw3tIvwJTcrnexZfZ3TH3SglKgaJ6csVHTDVqC5s5ggGdB7ZDtZFMzXmYs5q5i
         mmO4exZm80dCC2aXJHxEvrM0Q4ydEkdf9Ni1t2oA+FnRk8A2JQkfsO2CUX0z9w0NOdDV
         AWg1WvcYPeOkKKhoWa4a6+bqti4TOpZhxcyWcaeUrLmNnONPvDznhH55PX09PNXmnsDE
         iv3UB+hvCmCZALbuLY3so37J5/HtlBm1RWTwYuGnEeqF9knXoOYZZR/dbxxYYuz8ShRB
         j9tg==
X-Forwarded-Encrypted: i=1; AJvYcCV1Tzkknx7H+1/S/KSR6rDvJv1RmenD4YCVTJzUqsUTGM+tPwF93TUFq3QBqynDvm7VkBDLdk5iZ+PvBb46fA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywsb6EIJ0XCqIWfO8XF2JfSJeiiDDneWtukHASZu4shnnTfMQ60
	S2cWjlD6QFcgBg2zexOxzOZkM4So1QxgYp9VVmj4Am6ojjvTXIFwGLpR
X-Gm-Gg: ASbGncuk8EWdtynY9sCIAD31lfGsS5PBWO3RCKfgon/o/DshDs3v5mGbb+MBh+42jzl
	r1JuC16Aurv+YmIWdgbGk+a//A9m8lj267/drVIIei7jjbq8zeAcZlMF61FSRT8N70TzXYyoKho
	Cl6VBw1U26cC/yQdeSD+/+qyQyBKxrZYuLD6YgBcKxDzQphq8wkDcUv6faeHogB8YEOy9dbQSpv
	jq1WKYjPQpxHEEaoqRbghIM/zS+czBxiuIVQum7SaEthJCVj1Ck+/dm/zl4UIMIihNFpBRWINgN
	DhMIhe5/HLgQMVUPkyn30uWpxOOohmnFGLi1OZiTqsgVAxmbngfIuxtCj9WlDsgcV0qKwpESZpS
	jc/8+m3rACfTe
X-Google-Smtp-Source: AGHT+IEJ8WIFf9X4wGSznvxjCKq9+or8baY6JK/xSM4+M8dwgeLla+mziXvq/7bTmdPlq+UE2gO+Pg==
X-Received: by 2002:a17:907:3f9a:b0:b04:590a:a5b5 with SMTP id a640c23a62f3a-b04590ace5fmr169723166b.24.1756823804683;
        Tue, 02 Sep 2025 07:36:44 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0432937d7esm447457966b.17.2025.09.02.07.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:44 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:23 -0700
Subject: [PATCH 1/7] netconsole: Split UDP message building and sending
 operations
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=3991; i=leitao@debian.org;
 h=from:subject:message-id; bh=uv+sRDVE9UdYp/rrXBaRI2PRNEO+AlIgCJajD1luaOc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5rHYtgODXvDjBr+4mxuJmvXSRnDOQlekjb
 8uY3bQrCaSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bQZoEACHZ96Nadl46FRJbWI/4E1Gzzlm+kqKGlfPX+MXLMSXtiA6t/LNDeliZvwvYJiYzN8+7r8
 Awb69iYfvz9djH/hl3znBuNkTrOmRsESsRyS/PXm5zImdPeRKl2p1tyS1sZQ1YMqrTZEYdMAZQR
 kctI5ZkHKBMPlcG04WXstHdTivxfFwHd2tKSxzZURVM37KCL2xbkyWAhQAKwozTjUqLurnZ5t3i
 IlxxhHdfTHJRd2uLPeg+Rw+WiJX0YWDIzb93Vw7JW5rPO62VpeBwLZBsrnc624n0CGt3jBMIGo7
 auEEY6aUqYigyZRb4kFheTVV/5FPxRkBPVUn9+zZ0zku1Ot/LvYW0EvYz9aKTVuXL5fMW98B4A8
 cjMZCBkjXKtZzdUp6JncE/QBh7A3ZT4tGPgqrlCid7oxxkR9aunXzg9JWwREbCR7q9KDtI9Neqv
 Rd6sYGZ8ulftOsHlBt7w7yjmn80r2H/ZEqVdq1+wM34HfGCOnVegXeb27o1syUR4kiRhAAPHRzR
 rLmlSbXSzLNYBBMMmctb8hyS9l/pVQtEHR/ljDRUcvDqHqT6RB4P3YsSQ5Ju4cBF6BvP+VBQ9uC
 1Cr5a4sDBf2dtiMFUOEFHhclZycDQSQzdPAHCJmFj911hdVSNMlUaeXsTRQhD27uVkLuaPCAvhR
 iOXVNTHBxNMOGCw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Split the netpoll_send_udp() function into two separate operations:
netpoll_prepare_skb() for message preparation and netpoll_send_skb()
for transmission.

This improves separation of concerns. SKB building logic is now isolated
from the actual network transmission, improving code modularity and
testability.

Why?

The separation of SKB preparation and transmission operations enables
more granular locking strategies. The netconsole buffer requires lock
protection during packet construction, but the transmission phase can
proceed without holding the same lock.

Also, this makes netpoll only reponsible for handling SKB.

netpoll_prepare_skb() is now exported, but, in the upcoming change, it
will be moved to netconsole, and become static.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 21 ++++++++++++++-------
 include/linux/netpoll.h  |  2 ++
 net/core/netpoll.c       |  9 +++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 194570443493b..5b8af2de719a2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1492,18 +1492,25 @@ static struct notifier_block netconsole_netdev_notifier = {
  */
 static void send_udp(struct netconsole_target *nt, const char *msg, int len)
 {
-	int result = netpoll_send_udp(&nt->np, msg, len);
+	struct sk_buff *skb;
+	netdev_tx_t result;
 
-	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
-		if (result == NET_XMIT_DROP) {
-			u64_stats_update_begin(&nt->stats.syncp);
-			u64_stats_inc(&nt->stats.xmit_drop_count);
-			u64_stats_update_end(&nt->stats.syncp);
-		} else if (result == -ENOMEM) {
+	skb = netpoll_prepare_skb(&nt->np, msg, len);
+	if (!skb) {
+		if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC)) {
 			u64_stats_update_begin(&nt->stats.syncp);
 			u64_stats_inc(&nt->stats.enomem_count);
 			u64_stats_update_end(&nt->stats.syncp);
 		}
+		return;
+	}
+
+	result = netpoll_send_skb(&nt->np, skb);
+
+	if (IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC) && result == NET_XMIT_DROP) {
+		u64_stats_update_begin(&nt->stats.syncp);
+		u64_stats_inc(&nt->stats.xmit_drop_count);
+		u64_stats_update_end(&nt->stats.syncp);
 	}
 }
 
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index b5ea9882eda8b..ed74889e126c7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -69,6 +69,8 @@ static inline void netpoll_poll_enable(struct net_device *dev) { return; }
 #endif
 
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
+struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
+				    int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5f65b62346d4e..e2098c19987f4 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -496,7 +496,8 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 		eth->h_proto = htons(ETH_P_IP);
 }
 
-int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
+struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
+				    int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
@@ -515,7 +516,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb = find_skb(np, total_len + np->dev->needed_tailroom,
 		       total_len - len);
 	if (!skb)
-		return -ENOMEM;
+		return NULL;
 
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
@@ -528,9 +529,9 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	push_eth(np, skb);
 	skb->dev = np->dev;
 
-	return (int)netpoll_send_skb(np, skb);
+	return skb;
 }
-EXPORT_SYMBOL(netpoll_send_udp);
+EXPORT_SYMBOL(netpoll_prepare_skb);
 
 
 static void skb_pool_flush(struct netpoll *np)

-- 
2.47.3

