Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E012C21E2
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 04:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998104; cv=none; b=q/L7pZtwalb5Enk+QgTJuu5LM4tcsVq4xRRiq01PJNf1BkP9js94WGfL0AGNVVVoxWHbngQi8ZwAhePrqzhP8yiQS0CPt3sCuqHFd1l/kC5lpyJVnZl+ksQRtfCU/m0Q4DtVWgIqctTN/gHzgTw4spMUIJlmX/9ubFHQ8txOsWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998104; c=relaxed/simple;
	bh=psJk8MWkw4yWUzhoGl6iC+/oKrIajPgKeNxYtGpbGJs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ph27U6nSo/E/fSMmLjOgT6bbcv0mvTBWa9cQKW/brKJR0BEmmxfUCXX2k7aD+/98JpYJRSDpEIt04Zdavt0jSfVvkV47pZqE2omCM7D5tyyxi+NClEYCO8u/3ojC8frSKLYvlaReh4bLx5jGw7u8lfJChazE9NuxOnxoMzG2nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9ySqTOc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9ySqTOc"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so56441325ad.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 21:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998101; x=1758602901; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=f9ySqTOcGlQXqmaConRrijallcicMeFSlMbH3aZ+j1rYeaMgpKX25qXaJXy4s1rj2O
         1DeJjzlCS1cwW9q1Int6mSPkerFfG3+hPE47+ohJaEn8gpjm/y6Pt8b1GGcHEV9487+t
         gqafVpaWYR8PZfzAeJi9PnHdbqdo/RoAGk47/cu8QQ+95xtS7lviuqo8RisRufKeH6k0
         wJIlfS24hc7TAM90mJe5NaERAYTG0DMOuGD3p7CUTZGXdxYgOaQvVm3vrlcGu7DDftna
         kwFT+R3OGd8mObdGL9i3bYdneJKBcLeHxcwSIm151p2460Sh999EAioAVqPKSr4ns6qz
         9d2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998101; x=1758602901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOaEQ/7pID9TluLY7/w8zgk+8Z8ChedlXZfnOV6tq/0=;
        b=rgPGDAWySh5OjcSUUiW6aEjaRzKA59cYI7ZstlXQ6cECLUBYTMm/vu379mgGR1bwnB
         FbhJESIMKCAHKHgwmfkgNjMISSCUbf7JZSpf/EhdCTk7zzRrFWxSdQtp+GEcF4Gg6tWe
         w9cSHfCGGQdqGy40dWfFLO9QvKHAEmTJpH9WDAqTbiMPtcGK7N7kExlnguA8D6Iz4DDW
         aBP9CZJgGKoSTppaPhy0caILGgKz654/pZiRDPOi8BibSm9FWJePAk+V59++4Yeenw/o
         ljyRLUnwixqJFSMdEErWt7Kri94D83K2hrxnMqKl4oFHt01oSB3kTMIwlpcZe9z7hzQY
         c+vA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ7L0puDlE0/SG/PJRAKyp8e1Xm5MTiGZZX08ttkqsckyis3coR5qBtuS7ifDTB1Jt4NjxUBRz6rGKh6dyBg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxo+a6FmOAN1u9/pxyBEfTl1qopUaYx0b/123UyDId54OvDtL5
	T6CxgEvplTzqi85Cyse3eDdarvhlR26MgUZHuIH+7lRLLmoeefT3D8yp
X-Gm-Gg: ASbGncukhUCWiFgHt4j0MDjBZ94PFviPwK0G8NGjquiA8MdkQEYipP1HjkdjGlqY8Ml
	GBcPtWjBfx534Rrjj3CPSHdLBMyGkWHZGWGU+ebKq26DBYvPU+KZJwj0chT2CvKAwNXdjtxAJjl
	jtIsiOUQotX49R2RpODjUGcjGLbu6ARiIBEgj2Xyaz5t/d1OMqqPHpECVEmllYoMTyfzawhjtzk
	x27svUaxm89aJC51zrHHxGiGpGKz4n2WLaZ0Anz5sYp/4T8BwAwvRVjaFSKK0YXphXRaSfBba9Z
	QNQFYDfiG+tsqzBWFzB5miT8eXraoltvVvHQCqSaO4wrDesw8w8530QTQs4uad6MRPKWMjxI8J2
	0ZLtS01Zxe/JmKqWyDxbTfTQV0qxlFFfhBfTAg/Y=
X-Google-Smtp-Source: AGHT+IFncLMpEiSXyRV3g2udd9oLTip5CIZ6fjiDS7nm0eY3IrUPzgwzagMuf9PJuGmIj5O4nns0xw==
X-Received: by 2002:a17:903:2f87:b0:249:71f5:4e5a with SMTP id d9443c01a7336-267d161e3b9mr10726455ad.26.1757998100825;
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:48:20 -0700 (PDT)
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 01/14] ACPI: APEI: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:22 +0800
Message-Id: <20250916044735.2316171-2-dolinux.peng@gmail.com>
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

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Hanjun Guo <guohanjun@huawei.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 drivers/acpi/apei/ghes.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..97ee19f2cae0 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1207,12 +1207,10 @@ static int ghes_notify_hed(struct notifier_block *this, unsigned long event,
 	int ret = NOTIFY_DONE;
 
 	spin_lock_irqsave(&ghes_notify_lock_irq, flags);
-	rcu_read_lock();
 	list_for_each_entry_rcu(ghes, &ghes_hed, list) {
 		if (!ghes_proc(ghes))
 			ret = NOTIFY_OK;
 	}
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&ghes_notify_lock_irq, flags);
 
 	return ret;
-- 
2.34.1

