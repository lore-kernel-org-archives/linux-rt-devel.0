Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC931A563
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823813; cv=none; b=it+Y4ODPmIAdbc9AfCbS80OlAfbcp7qAMrruX2VXzYpdF/5HJMXFZdxonZ4W4D3elG7EJ9AHsyefmfEyqVuDSBipeGHjZP3F3n192OMnmLKzZTV55uu2sqaeVf1nDkJItEgOKERUFE+xskhRVLuk/Ejy9RmUFdSrc5EdSA9PKYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823813; c=relaxed/simple;
	bh=fBTiCfurI7dxZQKPkwQFVbTBFADCdtM6FvMkk97zj/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIG9eftbB/auRlqGUrJwyy5FruBogf9RY4/U8ciH5PAM3rGmVsqE+x9xE0drSBcvYJiTX0Whq1xqC59ubx56W+mNHjmIVx3U2MUoGIZmXTGifKQoMIIPkTgicjr14KSSA0HtkBo2DDnLwoP8i2bXaIEft+W8s9dixC+Rga4mf5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61cf0901a72so8066211a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 07:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823809; x=1757428609;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdT0QyqHw8TFh37W3ZGyN5wTJOSamT7r/yaGCZKnaWk=;
        b=RmeJquSpJlp2eyrlb6uaX84rZcv6Q6bvPs9n5D14eOuKeTYYVihKUJ3gtPiW2AIDEk
         H9p4xdF5L8PCx29NXDe8+9FTrmZOUzvlO9CYLgram4uaGlEIHMap9waCtijpl6/63503
         FO98IrVPvZEU5U+MfjkUcA0gA0M67zIv1EueIlRG6z7dTydJctlIVmH0bZ/gKt+b8+oD
         Ld/vCa0Je7OIYyI756jbV4L0Gz8/NDnOAsqADAvS/mgZZnFFTe9EfBKOsdEHivzNHand
         EOZ4aNec3hkLGU/c7uDM4tzLXpylLiQtb//iGXjYroMoS5vZnyhPHRNx7Z84a1btGPez
         MYcg==
X-Forwarded-Encrypted: i=1; AJvYcCU+GxRo9XU/eGzxHmEoG701+g3aRUsLkcTTPWQNfu2Zh9peBNIsSz0+fTod2VUniSWFfhUmx5ejwmX04y55sw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz3RD8VCfS360cHfaoFxp8LKUYEnpN9y7nu/Gq6lZU1ZEUuiR6L
	i8dQrd/saDvHa0JX9B8d1yX6sx3+q5DGeDE6DJm86nZjoniJjwE8TXaP
X-Gm-Gg: ASbGncsmagt6VH/cZat6g0ytG39aC67e1eiyMaOgA3Ao5qdrmDJJr1j4xU9dtrtxwwm
	p1z4/xoYVWXnBwW0L/1crC/kA1AbbRLKDbUTXwNN4pn2bzPNDS4MyLDvra7yfLhFjAyc8naYeCq
	S2qpxBQpy6J6KYAw3IiK5ijCCn3JodJUs3grzH/ACb8tdjBXqZtgI1hC9PmbOBX2lZE6s+oqFrW
	ggSXtGcNCZSrxb0NCc+v2l18JapT3xGU2G5X9RxYOnEZDAT9DQJHwHyI1wJfD2S+Q/UO3BOZ6Gb
	VBwIyH9cmf2hXUsWVHnDhE8nSn8aFdrmWAH0J/kD9X4nByCPVpJ7kLIvtn+mcLc5ylYCiPDm3SJ
	OXxl7zt+tDA==
X-Google-Smtp-Source: AGHT+IEHuzvAoaTJbReKihr4Y0+Pz01K1SXjkSISpeaK7d+VFZby3xDPxx5UZ48jlE8bdq8epjBMog==
X-Received: by 2002:a17:906:6a04:b0:b04:37c4:115f with SMTP id a640c23a62f3a-b0437c41a5dmr683227466b.39.1756823809191;
        Tue, 02 Sep 2025 07:36:49 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042dcb9105sm504898266b.2.2025.09.02.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:26 -0700
Subject: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=leitao@debian.org;
 h=from:subject:message-id; bh=fBTiCfurI7dxZQKPkwQFVbTBFADCdtM6FvMkk97zj/A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5A2uswZH86oyEbSVUftlref/NBbjXIxRCb
 j8dbNrtpDaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bTnpEACaL/WY9SZPtvR2SrvKuVhDen4RCN5P/smxFwX/+Pj56tSnTIZHDAVXdKbQpovFZwA6+12
 pJmDybLaqffBt5AooIimbU/u95I7B511jO0rfU0oW78qXqgNFtq2Af31gjqGVMUpT3JW9E8KjDs
 nvQtDUF5TV/hXVE5ts8WQKHHp/c8xPyY80swiyeeEGX90UYPrjxV/PQGLLfnDiUiBecLU3M+hDO
 eDibeFkvbxt3m4T2FiFrcpdXIVnMGnpbJZa1KtVLKxhmTGoF1l/ezvHSKLILPOhjFu5ZSpN4kUG
 AUIKkaNgunm3Dt7tlOVm7DLNv6+Wpdk7KCf53N3lr3+F/kiOL9GQoIpR8OhMeZN3De7ZUwqRfqX
 ziMcq8CQEgQ+wbJnsr04Lm/pR5h6IgeGjQ57KgE8BLnh1eU8E/6eDl90QeVIT56ivszzf31HikQ
 ENcaqowI93CrDbVWCo2IH+wFA2EHbZBrqJscJYadl2hd96hBrpc+5tvB2E4E4o+HeawdX4GJXM+
 9Ik2YrwFZIwcpGjMLOB1hS2rU/LvnE+4w9h0MpOGfI+S7NNrvtV3kE/+ZoD01ltF16IxZdFh0cU
 mAsXne+MJBbDTQVVgoEy6TJ4zRO2qP7XKECKRCuWYMPiOSeTaeJPSBar3fuHGmWJP1Kf9VUwoyj
 n5OJ9rJtI2zDzqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Make zap_completion_queue() a globally visible symbol by changing its
linkage to non-static and adding EXPORT_SYMBOL_GPL.

This is a true netpoll function that will be needed by non-netpoll
functions that will be moved away from netpoll.

This will allow moving the skb pool management to netconsole, mainly
find_skb(), which invokes zap_completion_queue(), and will be moved to
netconsole.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netpoll.h | 1 +
 net/core/netpoll.c      | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 65bfade025f09..7f8b4d758a1e7 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -75,6 +75,7 @@ void __netpoll_free(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
+void zap_completion_queue(void);
 
 #ifdef CONFIG_NETPOLL
 static inline void *netpoll_poll_lock(struct napi_struct *napi)
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 9e12a667a5f0a..04a55ec392fd2 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -50,8 +50,6 @@
 	 sizeof(struct udphdr) +					\
 	 MAX_UDP_CHUNK)
 
-static void zap_completion_queue(void);
-
 static unsigned int carrier_timeout = 4;
 module_param(carrier_timeout, uint, 0644);
 
@@ -240,7 +238,7 @@ static void refill_skbs(struct netpoll *np)
 	spin_unlock_irqrestore(&skb_pool->lock, flags);
 }
 
-static void zap_completion_queue(void)
+void zap_completion_queue(void)
 {
 	unsigned long flags;
 	struct softnet_data *sd = &get_cpu_var(softnet_data);
@@ -267,6 +265,7 @@ static void zap_completion_queue(void)
 
 	put_cpu_var(softnet_data);
 }
+EXPORT_SYMBOL_GPL(zap_completion_queue);
 
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve)
 {

-- 
2.47.3

