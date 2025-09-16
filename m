Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365472E090C
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998131; cv=none; b=kx2ee0Dw6v9j825U7j7f6+10IAIBBMSR2x7D6gypPjRW/hx/mpzjDe2iZdnaG/Q5xWrfB9ZYbK0KgYinbAZdBgs55B47prm25Tp4aPHAiuSHOIFcyBwnlcxAPx/NG5mft7xpfkeljdSMV1eUObmpm23Rxlqy4v5grSri+jsOfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998131; c=relaxed/simple;
	bh=McKpF5pbp0B08HxMwaOQh+77moGljXjpv9ExEqMvqrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O1ammFMUDD0QykLRGNYHdtMkS4rAOW3dlFaaEgCUpHQrhOtoDKGxQO93oF3R556O4+84cZS6NNzihZjaNRJyodgzbf4v/ubay0sL3Ho2nXXYifUkXzcs7XHzjDCBYhtyzcvT0iM9Wb+qdkAtikNc1AiYoyGmQL6Njl4G1TIebnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZGVQ6j9C; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZGVQ6j9C"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-24457f581aeso49818645ad.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998127; x=1758602927; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=ZGVQ6j9CdvdBepsBHafOUgZbcCODGnepAe+JHwxWk6Cgnt3Wj8hH6LAMTqwVFTSSrW
         hbhu4zeZAjsRRuF2rm5u4bjtrb9aqp8hLtCtdbHFV1ILyzwM6kBuPMJ6HbtZGf8w6rL0
         sLNRHzQU4GzO5aznUcB7g5ydkqcmguK0tM9Eg7KEkDRF+ZEISgGQCIVAhF4de14S7prM
         wWjKJg0/vfxqlotQa1ETi/fdyP+y0xIhQC6kIaLZHwZqO1vDi5Ninw6u/sShmLTPJ8jf
         umdYvfLyELhOtN4htKimVIeOWr+fuR24l4lG1EL5AQ+LwrHhLmHLQcM99LRBYnLkvgnu
         vCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998127; x=1758602927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KdSOTRlpcbSm77LoC5qTO7Qj2WXZD3913QNmAyohauk=;
        b=BvXWFwDFb0IkRlLWMDMmofEE3qqwfFjzTsVFp40BTqZ2S346vCnsrz4eZQQQNCpOBr
         ibq4KtLC9qarQK6GHEkSRAu1v3eYnPVxs2xNmlMfWcNiMVYG3emvjg/IVa+9C1KMlpM8
         ft/cb81MSthlYKnnI+LlVb0vjCmfEX0dImnV5qO2gQwsyjDltpkvhYkW8knGpvcIAUzi
         J2QKyEp6oc3xWpE+hNCe0Q9CF68cyjg2NMAxi7QsbdlbuvKFULNsob6sBx8xZUO0OJkp
         76bRFIjQ3RUnw+SioqpOJ8pr8kiR7iWU9ogRsY3PjHyab9L8OhsL8OWUGKN6sZ9V2v05
         SZWw==
X-Forwarded-Encrypted: i=1; AJvYcCUF0v6JtGBZ91tHomY1c7xiZvIdTp7yKNAnBLMQ+7AtkPe9OZeSewBuT0UqWeVXcZxXrZkyIAdlITn9TWWvfA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8drSsO/fFE2QdE5U+47SIPQyqjGotIDYQy5jSg6uHnIns0wWl
	WFYJRz8WjkYbsTcql7W8kF6wIMAa+qaS6fHpzA/rZl1ITHv6HeJOdNYy
X-Gm-Gg: ASbGncsXOSMS1StvLAwD3m63De2sYW1evz4e8ANTVl0xihMziNCGi7w+zf5vt3BHHsD
	lg+Lk9+pJSHS2CdVvTostcD5jw7vI2fiWQUpzknQ8rBKii7ZsNjE3UTf7FfELiXFUVSPClGRKFu
	xih9t1ROH3yK06KW0wx76jieImn1gZUioZY1noU9wGhkGcRhAERRcKKpDyl0tcKD7AQnXUifooA
	SwBY65TIDcam8QNId3EwEM6lykHAZ8OEDJrlPhjHrJXExcpLENALabEm+V1WfxLqUW+1TSVQAky
	35lw+RqoAZFVa5/90o+RHlCYpUQjJ/1QZHI5rrpDqaP97JdiGJzehnrHyHj3Fc5HmhYjxDp9E4i
	tUNk6bEPMou4tgHiWJrtEZZwNgvJ2ugLqg5Rcl0c=
X-Google-Smtp-Source: AGHT+IGkIhcIMGh+oiZ/aDBZPsHwPAhQG69OhML0E/f2mr/YjQA5clLbS6Ua4uwzILjLJIA06eQ5gQ==
X-Received: by 2002:a17:902:d2c4:b0:25e:5d83:2ddd with SMTP id d9443c01a7336-25e5d832fdcmr159755585ad.45.1757998127447;
        Mon, 15 Sep 2025 21:48:47 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:46 -0700 (PDT)
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
	Holger Dengler <dengler@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 05/14] s390/pkey: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:26 +0800
Message-Id: <20250916044735.2316171-6-dolinux.peng@gmail.com>
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

Cc: Harald Freudenberger <freude@linux.ibm.com>
Cc: Holger Dengler <dengler@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/s390/crypto/pkey_base.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/crypto/pkey_base.c b/drivers/s390/crypto/pkey_base.c
index b15741461a63..4c4a9feecccc 100644
--- a/drivers/s390/crypto/pkey_base.c
+++ b/drivers/s390/crypto/pkey_base.c
@@ -48,16 +48,13 @@ int pkey_handler_register(struct pkey_handler *handler)
 
 	spin_lock(&handler_list_write_lock);
 
-	rcu_read_lock();
 	list_for_each_entry_rcu(h, &handler_list, list) {
 		if (h == handler) {
-			rcu_read_unlock();
 			spin_unlock(&handler_list_write_lock);
 			module_put(handler->module);
 			return -EEXIST;
 		}
 	}
-	rcu_read_unlock();
 
 	list_add_rcu(&handler->list, &handler_list);
 	spin_unlock(&handler_list_write_lock);
-- 
2.34.1

