Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B0243968
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998144; cv=none; b=kJTQTc/acvieD4U0TtcrmRwpY9UQv2uSgoxIwqc76h/l22bAVhmdnzFz4pPADp+m42WvjDTdl+RkEAevEKUcWsfGTEkTpf0XuVQiLHu+niw2F48SgstdKr7S7mqGHMLcrnvZE7Aa6fkCgYD4b/szTFTiQhAO1g5SDcMuU4cFBBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998144; c=relaxed/simple;
	bh=HguuC3cJW9LHrBXuF3iFTqdhADSKZ6I2ZWC/adsG6L4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CrdE+N+ZGUNQS024m2C0LxGrebtogghyP/AyBpCZXhBpfjyxWE3PXGzObRl5Z7WaKxElwcXbYe3MKPNb4Z/oPih27LKNjxsYtcmG9xNX8Fvj+yM9VJohS1QTsQO0sCE3NMtk3GkNfqTdZECjpsMjXi8uRTe1+UXkhevV4xFvd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEGs+zEV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEGs+zEV"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-244580523a0so50862785ad.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998141; x=1758602941; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=nEGs+zEV9AM1XvUbw6O0Hqsv+qxDGzP8anlK5fOVtqQNDfgBj0akzWyCF55XgL3Tq5
         LrL+t+RtkQEWxAy/8JePeMsbr8TKhgDOgMNAHwr6ObTBt7yNnfo0InJpIbTt5Nhilvrd
         Km6KjmMRE9bLodl8GCW9MrBAPJR+mWuOJ8ejgHVLPMWyD+kRDnj1DP4G4UCmPtDknflN
         1X9a9gVHl24xmsw6LtgXHKOXh6KrluRc04V5qrqcLPz2pAfjz+S/enVTZS1Q7Dv6Pfum
         3+elRwukH7D8tIHM9d2qs9Jb0fXReGKP79GWHSXpJV7TGODiv0iisug+xYiv8KbsObmm
         BxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998141; x=1758602941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y26N2MyOP2FIPMMMBT4JTn6kc4P01rdpdKyvYPEfOYc=;
        b=jQPA2pnwPRamkPARe04wOwq/oe3gNfZ142Fxw/yBbRF+f8c+CTUQKSuSPSKCa2bAsI
         tDh4v7h9JdL943UQpew6XRixNAGA0sPu39/bB0KRJ2aDsxN8qFLb579qMxm8sXuPs6yT
         kt6qnh0ZTVPBNjJJw6uZ9mUateRROTKnEG2obJrJpgPUnzAU/As6ahl9nFbBDf6NiPA4
         nmfQq0GhKkmruzG4p3uOG5os83ei5j6ftRBpJphmeP0DW/1MPv/tGiVgbYvc9+zkZfke
         VJwMeAeyREmlA+5SJ+crweZEpZWNkRrVGa53fApLe9kYBAOG+y8O2aVExNBtAhhH9jyH
         HSvg==
X-Forwarded-Encrypted: i=1; AJvYcCXTd8mF2coRtaT5VrkATAGLXxJq8XrfWxSK/YYFJm5cYW46issKgH7GK8tWGfAzuATYGC+qtAYT4v3NoJCN3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXvXq4uN/lkTxVnx3VHhj0IEoHfMuzqwzhieHNMDNgFyciP1ax
	u1QLxw0PdTaTbeRnlXjJeH1wRzVWfrcoopiZ1qEflqqP4ojqGEvLcL0q
X-Gm-Gg: ASbGncvhUlVdTv1fA+7ZmAxObD17KLcHQGvH7QcWLOE3tCe2x+nUhLrarlvKHripfDO
	Ik4MQxS9Ga4bjwFQDwptEh6lV7UqQKmAefMCJWg+r4blM17y4ZiXRyVZhHPpv8sH5G0bZm+oNt/
	/FmDZwooNCTPJbFzZzr0MU9rNBNQNdq16Dtgm7YjAZaBJw5cQGH78VokJAfRREdFHb1DzyZn3w2
	ovjq9e/kszHj5iHm1EnKnE0vIbepTpadCB9Vf+x11ETaPD4DGCTT28Q4ut8zIdKjLWgTyGeDr5Q
	BalXIm1w2IuY+fwZWbFCF0K0PUw/34M9/uwkpCNSFA0wsqv1gj8DyxbbFbusZA7upzdWm5tB5i7
	encWzjUULoADsdPfyZu5G5lXrtJJDpoDFjon2Rno=
X-Google-Smtp-Source: AGHT+IEF8hyGYSwfpfRfNi45Ml5S5Z1xWLwd/+S+vouYcjrRAMMRr1JH2N5TAK8bBOVvYAZpMt3b8w==
X-Received: by 2002:a17:903:ac3:b0:267:d772:f845 with SMTP id d9443c01a7336-267d772fcf1mr8896415ad.52.1757998140582;
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:00 -0700 (PDT)
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
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 07/14] yama: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:28 +0800
Message-Id: <20250916044735.2316171-8-dolinux.peng@gmail.com>
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

Cc: Kees Cook <kees@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 security/yama/yama_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index 3d064dd4e03f..60d38deb181b 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -117,14 +117,12 @@ static void yama_relation_cleanup(struct work_struct *work)
 	struct ptrace_relation *relation;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid) {
 			list_del_rcu(&relation->node);
 			kfree_rcu(relation, rcu);
 		}
 	}
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 }
 
@@ -152,7 +150,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	added->invalid = false;
 
 	spin_lock(&ptracer_relations_lock);
-	rcu_read_lock();
 	list_for_each_entry_rcu(relation, &ptracer_relations, node) {
 		if (relation->invalid)
 			continue;
@@ -166,7 +163,6 @@ static int yama_ptracer_add(struct task_struct *tracer,
 	list_add_rcu(&added->node, &ptracer_relations);
 
 out:
-	rcu_read_unlock();
 	spin_unlock(&ptracer_relations_lock);
 	return 0;
 }
-- 
2.34.1

