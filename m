Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2A3324B0C
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823811; cv=none; b=rneD7ANH4GKZrAAHmJxEe+og/SP6Ku3j5+kjfh8MtjDUZ1hoVmqTJo4kw2BX1HITG+On0hj7V+tCRBK277TLIL0c3Jalk3YxtNY+SkQmIp8VRDK3uVFnq6F0s8wjTcbJjW0hsp9KiEe5hcyr1c5+9HPnKiL5Hl6UZVU2cfbVdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823811; c=relaxed/simple;
	bh=vdJ3o7SQzqokdbSPEfnxGV0IOZXYQuFhEVIrfm9ulm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qmjd5Fak3VWmmB2EJIKtpqeOShT1FtZ7MkaJLTnXmSM+XEaXbRnNljBVOFAF5cK2kBk6bbRhgplDB1O1Jw6FjssetShdOJGtT1yg8oqNooc+/9CJHZRh4pFhGZQv/tPV0UAFoJm4EB7rEafjQ3tcldRNFcUxMHFKpVhZobIpcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afec5651966so379151066b.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823808; x=1757428608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiAPf+HDKdH8QBueSzvHjjUvhHwaKw+els1x3HrZ4RU=;
        b=iaeCKWMZof1//78CmA9TZ4yweM07vPfZ53wv1EviMjOHKfjrF+ygmdD9EdToECPV0u
         N48G4jI4FzRngNacs8yp9ny56DykNv97/tS7hh/Qa5RCNY2KOa03mZHK/aUNn32ihwiZ
         UvDSHhCUQS6L75RdLhJW+s668EbhXt3+5lAoWyCtnNmFvpZsJudCm+O/gdzsUCKSXlNB
         Vko1e08hiSZjdMS9x1wOKoR6nMaWCe0echx993n6fxWScb5LOO1K130/KEUvGcWPp6/Q
         Yuh/ORDxVw1gQZ2BthmoDrVKGYPcoDmFz9ix2eIWouJ9ef0d/mZwLFOtSbaOW3g8I3OD
         Gy+g==
X-Forwarded-Encrypted: i=1; AJvYcCUvZPUqguYd0s6DgaLRAwv18WqNlqIfdSnNuwSC+rawmmMac7X8HZNkthnGMoh1kvMOES4R33WtLg5knb66AA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWB0JMJJURXiz6KQwkt7Rxz2oAbexGAZgDu151Pi6ajD15k/wF
	2W54tUVeo92INuy7C3gC4SQkg3/hjmCNrpdGTbrFB7grJew6zTswH0gt
X-Gm-Gg: ASbGnctoAUGuadqrRt0WRzdnA+/aOiYo53GTW7h3AK1MKZb2ZMNvE/HhXIuj9sExRW8
	nvHWA5E8XAbjRIjrDDTpoZ0hTRNMskAvouJ2EMAP80rgqWewgGUo62IxMYFXaK9DB3nUPDmyvdC
	kzus5Ex/rM5+4ydezL1ABwqRUvMjxbSrEc4Hm/hM1uwxEYt7ID6i0FInd4eAtupOk4lYYox5TyU
	vLwuUN8zR9ssRJ7OF3zm96ihwOK+2iKWyYTXKusTdpq7j/s7VjBHnTN2Nu96GDIbTfoJ5y4UKUu
	1cbqd0HV2Vxs2lrQ0DAtiXGrn+wE67rdf2DIqkewn4F7fNdg5v9jAsI6zzonAZ4SYiCdiJC/kHJ
	CnO5CGj7sqLUF
X-Google-Smtp-Source: AGHT+IFBbylTXgioEB03UJeR/a9ael5sSxKGno3BrjK1Q6HEnT3bGvVV8SiL8gFlPBGOoxtICYj/2A==
X-Received: by 2002:a17:906:c445:b0:b04:198c:54a9 with SMTP id a640c23a62f3a-b04198c5b14mr763047966b.61.1756823807717;
        Tue, 02 Sep 2025 07:36:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm523355066b.71.2025.09.02.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:47 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:25 -0700
Subject: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=leitao@debian.org;
 h=from:subject:message-id; bh=vdJ3o7SQzqokdbSPEfnxGV0IOZXYQuFhEVIrfm9ulm8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5fUdVRbJh9XQBsFtAPxXKE9nRNZAr8ehgN
 T8VUZFGtkWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bUFgD/0QFYgP3e916ToEj41ZVMjK8Hy81YOhOrzdsh/fRhQenOOgsfPXPa5TBmbSevlZZ5Qe+nW
 Ati0sKNcuAhwrfir+A2iCgNb2KzFkwhvJOWrea3SMDEmyp8Cs7AbtV65sI5AUI8+pqj0w5amDPU
 h2ic3xNiHxM0ytgibne1aasxf1Q5kKWsU6zQ51EzNZ1Xhh5pQqmuVGC9UfCRczH5ZNhBc/eQNXG
 AcGPfppgEW3PEcSO2GwMH8ff96CKwK6DV33CUlvNcUTf9e8NKCLym3Y9Jru88mo5GqRsV38/uRO
 0JUN7TEPmFDiB/SROV/97ZyIKG4DeFeQunCDFMqgoOr3OXeiDdu3VyWNmlAbaL2nFb4S58Fz4Vl
 P/iwHhTb0UpZgSc75k4ShSWpcNuMcHxuO0YhPLaCpli/3VivMJ0ldbbwlSRYsN/bTcDoKhLu3oe
 +Oj+7wdrfj6tIht+6/mEkWumOc5N1WI6EdOdHKykOOKlrKQ/8oVTqs6SEFJosJPrjpYsYsb//fW
 9c+WGN1k+20B6q+gIZDCEPDphQMVipXOekj2DOKamwFHlG/pm0Mn+5FR730HGVC+qBAl7x6ej6a
 1bJqsFr8yHb6x7TpAtXh+b2saL057ftY4+veU9MtpGzViT9oBQNl52qBNH9a1Lk51hG8k3E/nIa
 YEB2AaE2pObJCvA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Shift the definition of netpoll_cleanup() from netpoll core to the
netconsole driver, updating all relevant file references. This change
centralizes cleanup logic alongside netconsole target management,

Given netpoll_cleanup() is only called by netconsole, keep it there.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 ++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 10 ----------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 30731711571be..90e359b87469a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -260,6 +260,16 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
+static void netpoll_cleanup(struct netpoll *np)
+{
+	rtnl_lock();
+	if (!np->dev)
+		goto out;
+	do_netpoll_cleanup(np);
+out:
+	rtnl_unlock();
+}
+
 /* Clean up every target in the cleanup_list and move the clean targets back to
  * the main target_list.
  */
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 481ec474fa6b9..65bfade025f09 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -72,7 +72,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
-void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b4634e91568e8..9e12a667a5f0a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -703,13 +703,3 @@ void do_netpoll_cleanup(struct netpoll *np)
 }
 EXPORT_SYMBOL(do_netpoll_cleanup);
 
-void netpoll_cleanup(struct netpoll *np)
-{
-	rtnl_lock();
-	if (!np->dev)
-		goto out;
-	do_netpoll_cleanup(np);
-out:
-	rtnl_unlock();
-}
-EXPORT_SYMBOL(netpoll_cleanup);

-- 
2.47.3

