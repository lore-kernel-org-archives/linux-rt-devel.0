Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2162DE202
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998117; cv=none; b=ClMmT0alJeZ/qog02LW8NngdaY/TcvpuT2UCyIKGcXvzCP0Qng6w6NFPvYNwETHb1WPdjmEWDsxgM51tlrOPX9RGlGS5z0hLVpBosCVyFQUO4YaV8+tgCeDpCQn6yxboVFfVnDV5+kC/xPxxC5XGQcgKoDq269n8Gp/VSBWsO+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998117; c=relaxed/simple;
	bh=ivk1kCPJFe/BzZPF72WSq3DpdkZ7hkdmk3r9ydq31tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MrcD0l3MbQ7AP8m0/0cynRL31elq8I2/9JBF/dq72Pm7Uz1m84x8Z2+YK7qFgK9WMl7eFOo1MhfNq9aiuLCQSEK95y3x0ukt3tw3P4bWkJLXuC58AS73yWAGgr6rCiuomyNfrm2r10ZDC5m+WOUECXaWY0HgoLK5lp6dftgh48o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5GNlswn; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5GNlswn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32e64d54508so1703141a91.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998114; x=1758602914; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=L5GNlswng97LItU/GF4JUmdWHxPnb9mNjFmqJtuUnDOKGutcpe/HG3ys8E8zU2ELir
         BbFO/shfxwABKNQgjVSMzW+xA73YBm4cZsuEgJ2UhyCcSxbO49Sh6q7KRY6X8JnsDE0p
         WlBhxOcQ7R0hgwucWPjxHgeMY6DhMHBjYHyLd+m516kwwD5j99updSLuasd2BBumbDkX
         gMBe+oqutWWsE6UrxiCPxAe46l75sq7QwnAq/QQAyXFvse33rGaIiWdL6opMu+HHK2ds
         Hoicbg7pTm9iI0n1qyrqSht2lpf0tDtqbQJScS6dz9kCLoCAkE/FO1P34+NcL9t+lqmY
         3zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998114; x=1758602914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lT9DsPVy8x0mlOTAyxJueu7zb5O+t3UCUBl9ED2OMzE=;
        b=TN0J3555nsowzRYT5f+SNix0OwBLYhAEVBrYYeLFovpx91BM/SxQ5mJ4P52jaTgnC8
         Cq/9RpLGJU84vUF3vm7prq6LO3iceQNqSNR1Iok7NUECkXxwODyCFZiDvpP/xyeToA1y
         E5ZLh72U+a/sqmGYGtFL9Y7RcsZpzs5Algk7j/v6cU+stO2hZMKSzoOQm0+2L5wkYVDx
         x4hcpS6Lo5aX3WeXVUV/yp1HO4YTMra4mHClbe9JXEFmm/bfwfqzBdU05vXjF9nxlQQq
         U8vIOrgt2rM7li/RlSXedLoGDu0K6Dq7+sSssj5ROo8imbojvgSCjXl/FOo5W7oM1c1w
         fMxg==
X-Forwarded-Encrypted: i=1; AJvYcCUh0xkCY857PbtdrfU4jnXgLgLLDXdUnZqEWIE4oJqe+yrYC6JkHMAr1FDeKSeYpN8juBA61HogLNtvt/EO5Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGYZ/ICGaNZUyywlPJLDaGmp4AZczmh1i+UjOCTfmBLPLnOPtN
	sDNw3exhzyiphvA6HjLH1c5HUat9T1Ip+l2hF3n9Vw85twjf7eYbnkHQ
X-Gm-Gg: ASbGncuvqvTPwXJ5wsBCmTnu3JooyAQ4hIsKqQ+K+4H2T28zNxaoB/jpbzME36Z5DQP
	oRhm32Munbd++qkQr8REoWmjZSFX2A/Ti+Zrq+QQV4h+WaboGtAQaZuquMGE2NWIRLgS1/FQIRB
	CF9iBMnYWa36XeycigaxToLdNMzSth+laUDjL05NQFslWg3mkIs9liFRsPLSlK20Asvrpu9u4DA
	NFJICJIlx+eTT5sto+3k25Uuqs5fNwDOCT0HySbV5ctWfN1P6UgJCo79059gXbx9TqIB0SkVNc7
	7qAJtkfXjr1HxhSWw9otf+4lnyS0oYdoEGgmVtgaNH1jLhpOMPEL22lpGhGn1cCnQF3XKicW/Tm
	oDI1b0lQJN1tkCq0cemwYi8ndZWoah30XPDD+w00=
X-Google-Smtp-Source: AGHT+IF+n/WS6RKuYlQuLpfTYPIbA2M/p4imTXrTMvTksxJg/G6gJFeTxjjE/2igpzRcFyrC5Ibdeg==
X-Received: by 2002:a17:903:3585:b0:24c:ca55:6d90 with SMTP id d9443c01a7336-25d2771f4admr137080665ad.61.1757998113981;
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:33 -0700 (PDT)
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
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 03/14] fs: aio: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:24 +0800
Message-Id: <20250916044735.2316171-4-dolinux.peng@gmail.com>
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

Cc: Benjamin LaHaise <bcrl@kvack.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 fs/aio.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 7fc7b6221312..e3f9a5a391b5 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -359,15 +359,14 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	int i, res = -EINVAL;
 
 	spin_lock(&mm->ioctx_lock);
-	rcu_read_lock();
-	table = rcu_dereference(mm->ioctx_table);
+	table = rcu_dereference_check(mm->ioctx_table, lockdep_is_held(&mm->ioctx_lock));
 	if (!table)
 		goto out_unlock;
 
 	for (i = 0; i < table->nr; i++) {
 		struct kioctx *ctx;
 
-		ctx = rcu_dereference(table->table[i]);
+		ctx = rcu_dereference_check(table->table[i], lockdep_is_held(&mm->ioctx_lock));
 		if (ctx && ctx->aio_ring_file == file) {
 			if (!atomic_read(&ctx->dead)) {
 				ctx->user_id = ctx->mmap_base = vma->vm_start;
@@ -378,7 +377,6 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
 	}
 
 out_unlock:
-	rcu_read_unlock();
 	spin_unlock(&mm->ioctx_lock);
 	return res;
 }
-- 
2.34.1

