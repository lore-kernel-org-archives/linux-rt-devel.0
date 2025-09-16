Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88152EC08B
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998177; cv=none; b=f7IhyB6nZlbZ8NmD5e3jYmICl378zpJ4dDdkIcbQAjhgMfPwToTYMPxl7gY0hvXM/ja83bsjil1NXb4h1ADUhaV9ctiNjAREnPLwGE1TTlFuOMId9tDmMLWs6b7Dl+/aDR3lZcbvaB84lT0YCc12NB5utm2ke8tKMN5JLfAGVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998177; c=relaxed/simple;
	bh=dy9spvLipBJ0oxpRy6D3U8JeqM1cA+2DUbEARoiEIho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rXd9KQ6yVxNQPOZs9OBHXISEemHeFpgK5W4Ka8MM4CAIL+lW9r/eatNds5Uv1M7LwpU1DsiNLxcvTzRSv0CZsyKNYLV1QOPI8zdh/xNCsK9nKPypzDcY9Jhct3M5FTU9sGR6XnZaAENFtscOZZ6MOTFpRFxg1Is8hff7HJVhLww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3DXQxXr; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3DXQxXr"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b54a588ad96so3311317a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998174; x=1758602974; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=W3DXQxXrDuKx7/N7uNnuCus/AGNf35g6YUF7h+CMGLEMvozLGUxl2XZfj55/1LzceH
         2+ZiWdIrjIULX1ypBCicwTHiXymNwITG10JKFouK4/z+jP/Qkw7S9w4RYwwCCt+ct0wa
         7u8lP8HM3ZvzCmSJBSACnzQ/ZId9TrIabR1HSNEm+GvD0GbWYCgCXOy8hxstrNJxRw1T
         deVT7p/PUJ5sQdvR8WafmS3CVf7S8r3SjV6O2Utr16YdGBYQhC7pz/G/Jo36wGAatbXq
         WOZ/prLdZADZE3pKVDunC5GswH7+M8Wz1aNf4d4r9H5dPBbD44j1lu5tPnb/LsSs0EfC
         pT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998174; x=1758602974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kee/jWM05xMj5MjToYK8a9EUY/mguZ7xPQQnB3cJ53E=;
        b=FABcoskeD6GCllgT4eSQeuFocAhPQIO5tAKshEBvbuyYzJBBvCMhMF/FH/kUzvYV4i
         BwKRI8L1ew/rFe/slth/SK5rCuSbfNYHz61uCXXCyjjJ9aJR0eV1NmbikA63JZYCcoX5
         aC8D2HzMuCPmuM6udVFKBtsNHltjMUUJHYv47r7QJXuqScWKmR16uoedrrGtWk+4atv/
         esVEpw3k4SM845wZdWUTV5YszKBW5nSpcuwl7wJ1JTD8JpFtGEzwrTtk3LTJplB/ubQn
         olyOmZ9feBFKZSSHQLzPApkwtnn3nJ+J2NWRh581GXF5L6+kPCO6o9Z7JSu1tVrzk0M2
         YvwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUZG6cOmatXLJA/MQhWjG/zKDW6nZZR/oEaW6vt6WofGBtmrYnkawuQTOonKNFLiPsqyxV7fPNuoP9FsBKRA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzcGUhev37aEJ16QZ2+YPxKqbfJrt59gftxbzcNvXHGDsoTZe9U
	qCU+eVbagDXnYABd6peI2uqLqdTRVvBxMARswTWmBZnoE+bS0WeJW9Ug
X-Gm-Gg: ASbGncupid/CsZ+D3JOasRbP2AK3wwgKefp03FlnR90Kdlx0sNq5osB8M5RYTRBXhXX
	ho1KwM/dBsr+51Qio6dsECcd3QeMTvJP8eSw96DsN/uDbWGXSpT70u44RwnVZDQpl8wBlH0dk8R
	XSmPIAUEY6amKpDf0vIf7u4RPOHem2yqKwrAsuruPMrOE+hr6VsYonnmlyp4H1HoB3cViJQVoz1
	R7o7dvq/vBcNL3tehAPLF7rXoOamyOAgAT9nHmbZBWhKrP4/1UDrab6ccKLx6xAro504/6rdrMl
	fBHFmMFzf5/tOZYZ3pZIMQD72jvsmNjX/EFwaJQgsoZZBc48OejlL2u1UIvD5lvV6yvjM/fa0uk
	CS+t6g1EPVSpzSpg+ZEevHzRSQz7lLO/+B9lHY9g=
X-Google-Smtp-Source: AGHT+IHQsp/jp2h5qh/u2y0fwJLYw3kUJFgybrRxf3n883LnUrw88kxlxQMidQOFwo4KtZaOVgbKQg==
X-Received: by 2002:a17:902:cecc:b0:267:a1d5:7372 with SMTP id d9443c01a7336-267d151fba1mr14211985ad.4.1757998173983;
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:33 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 12/14] net: amt: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:33 +0800
Message-Id: <20250916044735.2316171-13-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Taehee Yoo <ap420073@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/net/amt.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index ed86537b2f61..aaed9fbc7526 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -295,7 +295,6 @@ static void amt_source_work(struct work_struct *work)
 
 	tunnel = gnode->tunnel_list;
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -306,7 +305,6 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -426,7 +424,6 @@ static void amt_group_work(struct work_struct *work)
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
@@ -443,7 +440,6 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
 	dev_put(amt->dev);
@@ -1327,11 +1323,9 @@ static void amt_clear_groups(struct amt_tunnel_list *tunnel)
 	int i;
 
 	spin_lock_bh(&tunnel->lock);
-	rcu_read_lock();
 	for (i = 0; i < amt->hash_buckets; i++)
 		hlist_for_each_entry_safe(gnode, t, &tunnel->groups[i], node)
 			amt_del_group(amt, gnode);
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 }
 
@@ -1343,11 +1337,9 @@ static void amt_tunnel_expire(struct work_struct *work)
 	struct amt_dev *amt = tunnel->amt;
 
 	spin_lock_bh(&amt->lock);
-	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
 	amt_clear_groups(tunnel);
-	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
 	kfree_rcu(tunnel, rcu);
 }
-- 
2.34.1

