Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206F6334376
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823816; cv=none; b=SBPHfY9tVsVEDnO5v8SjLG9k5lz00V+MsXokecBrAqNQJ58UR5EFTKlPuF52MAEGd0+feWLAreWGQ+nLVKA+n4M8m/UB1A3iCLamvyKzk3WQzISTxcx0xvKRYN089u1x3tN9Kvnc8WgwO7Ak5BFQDd739zVEL4yfsSE3kDJNqoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823816; c=relaxed/simple;
	bh=hEoM6CFJdWE31w8xFW6aTHY60k+r+bWwOR/kv/6lIlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J/4nFhjlEKfCT/XyS9z03zGCfl8QtkkuNSKvG35CIHovZRvzOCSQ0JLn+LPyO5lkclWZ5TX/Bo2ybDB+ncOmUrQCdMbbZMr1ge82eeJ5/1+2nap/8lQuptfHzO2s7EBWs4QGPxbxTu3PBeeuonL+z26IRfAKTsrDqKnFiGx2ymI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61e930b27bcso3054133a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 07:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823812; x=1757428612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRNRDuYiIKp0gOeHmM6Ebihd3noRhR1pzhy50CtibRc=;
        b=s6EahHqk7XN/Lf1atWlIXaPGnBAu/n/TYEqjnajvA5iGhHlJpbDe/Wx71kOs9ZHzSo
         G6f6pMP4veaJAYOIScTMTyXjV02o9Yc21HtN7/it8MTkF+ckWtZQ8sOvrQjrSV2V93rd
         OLYsT8uiyyh0gZFsqVkz/eT/HT3Bqy+zElJfhHfzqQ4RYGnYL5T78QhJ898tnZbr0N4q
         ecayvHf+gSgMogSGEziP/ISqaZo0IeYIS8L3RSU5tEQtJ+VeWEKTne9BasqVTOMgc0Ro
         kXiHdI1NjZJvuosB+V/GJJM3Hi7xXCBT1gsODrNR1kUMiYqrrIVdIphRk9s3maWXwKI6
         70gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa9JzHCdRpjhmJFGn/ftSwnaf2YUS9X2GiaimrR2ObrP31BkfC2oNKa82oY+cafrxfIBefQEwWgDRzzwtrsQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJNMd8m23T5ohQD9xQ1yGPCmxtLSkn1qWZmwonh4pz4b6k8J5D
	3WjziccrUJM85eOXfZ5Mz8yIhirjUNy7TC4Jh1GOvDIrKFhAzQJR9IrU
X-Gm-Gg: ASbGncvAeKvSq6/Atqq2pLPrQyGZLUDLW2T0dQhWvMp5gColiI0vyQmMnz084XdCEo6
	jjjfTIxsfbpYF10IC13MuzVIfXd8MehAIZ/4YkZNy3e1mT9xUp9lWnGY/owtBLykdYP5oiUlGh/
	PjBhdZ3aU19A3gl7ZsMeL/I9IDmJyIV4RHJdddg2SM2wlukxtE+Vm00797hAsqQKqPyqToUb4cl
	f5TZ17mkT9DfO7hB1OFQS3Zt+uGfyKzm2yHaI8IdGkG7CacB3WWctmo8uMa6NgY2StMTvsTgaEE
	8gKqk8Cg3+Ew50UUqipozztDzChlZaM+Sc+DQQTKzxU1/HKHeQ7lahHp/mt2FWbrPWFLQDQjT3a
	k5XItbVEcIqI1
X-Google-Smtp-Source: AGHT+IG/WSpRufGwBIFMbBbi+61qwCv7PSPv3muO5uBC52/ZhXkQb7Fx32UBp+CjF7KUcWoQPUAUkw==
X-Received: by 2002:a17:907:72ce:b0:b04:61aa:6adc with SMTP id a640c23a62f3a-b0461aa6b6fmr6842766b.7.1756823812082;
        Tue, 02 Sep 2025 07:36:52 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm523369366b.71.2025.09.02.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:28 -0700
Subject: [PATCH 6/7] netpoll: Move find_skb() to netconsole and make it
 static
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-6-51a03d6411be@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3890; i=leitao@debian.org;
 h=from:subject:message-id; bh=hEoM6CFJdWE31w8xFW6aTHY60k+r+bWwOR/kv/6lIlw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5xjohKd6EfSj8DIEFNfTJu4cHqZEarDmav
 ttZ7edvlSSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bXUVEAChtWWNrf/dSg9KAE95hR4+7Hqmjea00XpB7Kh+1klR1Igo/rVxU76NaLGb5LpGYXUOAnw
 9bhWEyULgeChkHaOoUAZ7b5+6zajPlyD4q3AhIR+4SRVZCIQRZiE2Hj1Swa9JXFxVFQcsJc0aTf
 NnJcgFAhD6l8elm2vnGN2cOn3RHavdnW11pVwAx4mmJgVHgY3mBuAZTWniHRoKO9vLyTlJwSiv8
 ODa7UwXT11sdxjPhZkbeNAXXVWghNp3mqvNUI08kqemEWPLck+elTmea7Y7ZRyt9oBqKApNNUHq
 ZRX4d3N7fxsB0iK+R1YWmri1hg532j/4yZTboJAh6cEvn92jXsyoPkB27+cThknfPwtXktSrWhA
 ttpSLiBQ+qgML5egeZorXWZ4qec1MwW50XvD6xiWC7+Vu06Mo+52YO90MzM6wSvv/BnX7W6y+Pl
 Tbn4h9CToSI0SlHE8PU3UNeu2N8JO9pDFHHWBgSXZDx4j9rRDe9S4OubXgVjWepOrwenxcokDxj
 DHcMgJ9i3VXs/AT4nlQZN67O+wdSjUSYyCMg4GGEgZ3b3lRd7JOTlsx/8VVZxD7NJG3zaDsXc8D
 IFHbC54zCkKjnyZsq4PkQdzjyE1A6SyA+Z5LOewNXwrg/KGueUy4dq4OOGWdtDtqJJcNuuw1vdq
 5vI0O6NBUG/W5MQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Complete the SKB pool management refactoring by moving find_skb() from
netpoll core to netconsole driver, making it a static function.

This is the final step in removing SKB pool management from the generic
netpoll infrastructure. With this change:

1. Netpoll core is now purely transmission-focused: Contains only
   the essential netpoll_send_skb() function for low-level packet
   transmission, with no knowledge of SKB allocation or pool management.

2. Complete encapsulation in netconsole: All SKB lifecycle
   management (allocation, pool handling, packet construction) is now
   contained within the netconsole driver where it belongs.

3. Cleaner API surface: Removes the last SKB management export from
   netpoll, leaving only zap_completion_queue() as a utility function
   and netpoll_send_skb() for transmission.

4. Better maintainability: Changes to SKB allocation strategies or
   pool management can now be made entirely within netconsole without
   affecting the core netpoll infrastructure.

The find_skb() function is made static since it's now only used within
netconsole.c for its internal SKB allocation needs.

This completes the architectural cleanup that separates generic netpoll
transmission capabilities from console-specific resource management.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 27 +++++++++++++++++++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 28 ----------------------------
 3 files changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3fe55db07cfe5..bf7bab7a9c2f0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1655,6 +1655,33 @@ static void push_eth(struct netpoll *np, struct sk_buff *skb)
 		eth->h_proto = htons(ETH_P_IP);
 }
 
+static struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
+{
+	int count = 0;
+	struct sk_buff *skb;
+
+	zap_completion_queue();
+repeat:
+
+	skb = alloc_skb(len, GFP_ATOMIC);
+	if (!skb) {
+		skb = skb_dequeue(&np->skb_pool);
+		schedule_work(&np->refill_wq);
+	}
+
+	if (!skb) {
+		if (++count < 10) {
+			netpoll_poll_dev(np->dev);
+			goto repeat;
+		}
+		return NULL;
+	}
+
+	refcount_set(&skb->users, 1);
+	skb_reserve(skb, reserve);
+	return skb;
+}
+
 static struct sk_buff *netpoll_prepare_skb(struct netpoll *np, const char *msg,
 					   int len)
 {
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 7f8b4d758a1e7..f89bc9fb1f773 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -74,7 +74,6 @@ int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
 void zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 94c75f39787bb..5aa83c9c09e05 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -235,34 +235,6 @@ void zap_completion_queue(void)
 }
 EXPORT_SYMBOL_GPL(zap_completion_queue);
 
-struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
-{
-	int count = 0;
-	struct sk_buff *skb;
-
-	zap_completion_queue();
-repeat:
-
-	skb = alloc_skb(len, GFP_ATOMIC);
-	if (!skb) {
-		skb = skb_dequeue(&np->skb_pool);
-		schedule_work(&np->refill_wq);
-	}
-
-	if (!skb) {
-		if (++count < 10) {
-			netpoll_poll_dev(np->dev);
-			goto repeat;
-		}
-		return NULL;
-	}
-
-	refcount_set(&skb->users, 1);
-	skb_reserve(skb, reserve);
-	return skb;
-}
-EXPORT_SYMBOL_GPL(find_skb);
-
 static int netpoll_owner_active(struct net_device *dev)
 {
 	struct napi_struct *napi;

-- 
2.47.3

