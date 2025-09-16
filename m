Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D84E2E11C6
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998137; cv=none; b=m0STsQ9yW/EQr46uG/yVBDIBfNfE1fk9S4Vg2C6BfZcAveZSW+59wvUfbq80JVMu5HtLzdzn6JxKAFNAa6Xly04DTB+aOkxnyVnS/32scoKGNHkiR7q2Ur5FzbccGv0krCpIX3qNL6S1p00zEPjzfaNnWvMSEztGRKpMp9qisg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998137; c=relaxed/simple;
	bh=p5MwokYTH6tczJBsI6u40p8nW7EOrH93nmvNjBcj/D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QRQXAqXhW2PhFcP5L1EBgzyEU+3tDyG5HLLD3ThDLLtnIVS73xLekuTGsJR9msG3c5Anl6esHxzFSF5DM4hsxCvShOGGh/P3OkkI3kF1wUPuhZB+lv3MpaJmWbpqtowMMlVIcmkulDn5yue7JXpktLyeNkVkOE2MPGtOvikCPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K2hhStQt; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2hhStQt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26799bf6a2eso13902525ad.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998134; x=1758602934; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=K2hhStQtILaIxeq4z3R6WMz2ZWZRqtBTzXuyEVhwavkaLKR6uU3LwEmjwrTDped6+t
         EHPqTj4i/x6PY6JqEtgHgpi8Gkmd8eS7V95dzKMArhd14dPv7BcXWUc/KVMPTOm3lcqw
         YVGL7CvspSBerOccv8Cg55jOIeSptvZHON56Zgwwm9zHBVVtJDjpL1MN3urlwu0dkvD+
         voQtgigg1CkogdRw9oNgicwJFqexWMM3NVjWMGNUIl/vMr2+uYyCSsqctOlb9iCFXAFx
         pOYO7Bka+m36RUrLDcbZQt3NBMHpfTNvhAb4FsXMGUp5BuqBuvNxRFvwX2DHpFen+7pu
         g7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998134; x=1758602934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+E/nxXHnOkpnquuQqI/t3YoOv7z+zhY+r7/SIcSNR5s=;
        b=Me2rnRYISKwD1qyfw6bqjEipZuXqX4YZLfEjCLR2NlY4WmOEHY0jYcq+K5CWrbdXBg
         tVwl+7YXzJQ+myoynyL+lu2jL5JkkV15RCVwugagZK3JHg8YCPpX95Fx/wFmsNteHIF6
         /1VCahLdYgn9cgbNju4SYkvY9X4NUeC+dM1DBquujvl1JRQE8uYL70y6cVl6UJ47k4Lh
         UEsszZOSUxT0Y+RLxm6br9RXsC/zxPYpcAvK9vhQB/uo2fi82/+9jo+rl0UV6maBA0I8
         W7yhbh2CKmPFib4gHQ+Ee0D04oHZZBgvuiBdQMCv1NNR/V4OjvZJeb0iw2SBVPq73EvZ
         eHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsZQqAAhbpH+UUFOsObBNNGE8KiI9e85CirqqLHs3q+F6nnvvz0MFuMCWj7mMx94P51wcWAWF8By93FsS6og==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu6VGhAiqpFNLP3F0P50lAwRuqwCSWXaKPSQCrCNCauA525E8u
	ihlGrjn4MFW1j/qmyx66cMikN/bKUPkoqFHQ2RxHp8i8YEIsS7hjDBYN
X-Gm-Gg: ASbGncvh9WpzBfSGW3gIlrddXVUfItU1IPiEBAgXDhyUeutr32VufdB0zAmLErgdTCk
	0G6Btt6eK8oc7K7xY6oTK/LKxYnGlU068g/dz/sm3nAyOYFdruatQxEKuyntaqiBdQ7qDth1n9s
	qbcr42BgQ9AhheIjjZS2eprQxdqbGn5G51IT9TOzMaZl+GUUsgKjgSFypOmj1xctC5fmmkPKl2b
	BYaAzbwreK5NQBXZV7BgPuifKFDapPiT+K/n7Tp5k3kW0jvgU0DnQbvFSkBH7CFUtrrhgQOysP9
	F4brhYPX5bmqPiY62o05zI8Puo5AKbipg2jg37OrZ4JHW6L77ubfQj2KEolmQObFHNewbdYZTZd
	kmv2DdmkQ3RJb0v3wK7sekOKQXbeMbPUPAP1DanxB+RI1owZdjg==
X-Google-Smtp-Source: AGHT+IHsN0GBYzT4MMuIYjW4jOX+BASz3i1Lsko5ULcFSIEXx1CyBAF2xoChVB4z7RicwE9rHAP4nQ==
X-Received: by 2002:a17:902:db02:b0:267:b357:9445 with SMTP id d9443c01a7336-267b35796d4mr43637625ad.28.1757998133829;
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:53 -0700 (PDT)
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
Subject: [PATCH v3 06/14] ipc: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:27 +0800
Message-Id: <20250916044735.2316171-7-dolinux.peng@gmail.com>
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

Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 ipc/msg.c  | 1 -
 ipc/sem.c  | 1 -
 ipc/shm.c  | 1 -
 ipc/util.c | 2 --
 4 files changed, 5 deletions(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index ee6af4fe52bf..1e579b57023f 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -179,7 +179,6 @@ static int newque(struct ipc_namespace *ns, struct ipc_params *params)
 	}
 
 	ipc_unlock_object(&msq->q_perm);
-	rcu_read_unlock();
 
 	return msq->q_perm.id;
 }
diff --git a/ipc/sem.c b/ipc/sem.c
index a39cdc7bf88f..38ad57b2b558 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -579,7 +579,6 @@ static int newary(struct ipc_namespace *ns, struct ipc_params *params)
 	ns->used_sems += nsems;
 
 	sem_unlock(sma, -1);
-	rcu_read_unlock();
 
 	return sma->sem_perm.id;
 }
diff --git a/ipc/shm.c b/ipc/shm.c
index a9310b6dbbc3..61fae1b6a18e 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -795,7 +795,6 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
 	error = shp->shm_perm.id;
 
 	ipc_unlock_object(&shp->shm_perm);
-	rcu_read_unlock();
 	return error;
 
 no_id:
diff --git a/ipc/util.c b/ipc/util.c
index cae60f11d9c2..1be691b5dcad 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -293,7 +293,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	idr_preload(GFP_KERNEL);
 
 	spin_lock_init(&new->lock);
-	rcu_read_lock();
 	spin_lock(&new->lock);
 
 	current_euid_egid(&euid, &egid);
@@ -316,7 +315,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (idx < 0) {
 		new->deleted = true;
 		spin_unlock(&new->lock);
-		rcu_read_unlock();
 		return idx;
 	}
 
-- 
2.34.1

