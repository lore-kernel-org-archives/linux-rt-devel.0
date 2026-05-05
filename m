Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809B433AD
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 May 2026 02:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947091; cv=none; b=YcAP36EJzHI+0je+6pBJLjlkosSMEy+MFWoMzYxgUoq4IdzKc8b9BvR4LvjuryMXwlD1PuIT/0X04/O1dSP16eSxbtjtc7kgQBnREJrt2MH2CBctLOwuBMn4HXGpLhlsrVsJQ00m2UC0tNqdkgT3Phl0HiSkzfNWfmuS9Wnhz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947091; c=relaxed/simple;
	bh=SoWri0A+/YD6ngHq7wp3P7PREk9CuwBSajYYcOdfKnM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JeTozV400oT6/HLHeeQFdPrg+Rg5O1wCpIoXuZZ41IcNkXRgO9GivY/7ntUw8UJjKDQ6ot0F6poivfqhgvPQJUygMht9XOuZhR9bfO7S/MMYMlIafYQxNc0JTIX0/zU+oZa7ukPnwimvrqQ9cwpSPcc/diCtCNYUG9SnUEOhoFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUEetTHE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUEetTHE"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8296d553142so3550985b3a.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 04 May 2026 19:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777947090; x=1778551890; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CA0CGfqERkEUstHnK51IlmGYUxmV4Y1TyJUGnxjU+VA=;
        b=AUEetTHE0/WTCe/zYcX1fDOtzcP0xEmcCnjuverkr5gzSHqimAkhr5P8dLDSvywh90
         SK2np/HEZzbDo0NmlPDX3B4GDjEHzdivYi3RgKuQfoSKlqi20utBMTvXb57EErd1gRti
         Xshmw7/YpXHdhXEESyDxMGawP/d2n78oUe8yPhWk9b+Cr2bZr8dv4PHvR/sZAWdAUCC3
         bUBf6YUKo3QX6GUSR/9rHq1Lyr3ZG86E3HpqD4l2HJlH1aKjJ31HW/7/N+wNY/jAkwfR
         tZ7MolK4YJxVj3auVoT0NgFQHjUypOvNGjBjpsbgMgV5aPQ5mTtVE5SGZieBBrdwhYud
         81hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777947090; x=1778551890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA0CGfqERkEUstHnK51IlmGYUxmV4Y1TyJUGnxjU+VA=;
        b=i0uOFKFk+H2jyF+idp+jnFziVpQdPXSLLLgSbEjOXIDtfSYIcZyMW0LoxS40d7rJ0i
         KDbeAEFBE4mNnc94zWkFoCQx0D2uLwiL7OBu4d1RYoa5700owstBvvfNanIHV4j0Ljej
         D/0MGhYpPjGgcFEdKyIlJq4O2yS71SdR3ftU1jYI5mRm+rI+GiCOasuB+2eTXjuWrM0K
         qN8LR7Br67aPn0H26BayEf6pttbVJwWjkeRdNRo5RlWEt/k/fsguKHX9swG/35y25ERX
         rmSmb8u+rHghWILjph7plq2/iNX1drozLUNqx8rX62nN8UWkEwhtNOOh5yfmogNvTKJi
         bkqA==
X-Forwarded-Encrypted: i=1; AFNElJ8jvnuw8jETSqCS80M4foEMA1gzwv1Nq5bIE5yiOskXzAiSif7K2Nkw9aN0jF3WsqBB26CDdEBEgmwCV0x0HA==@lists.linux.dev
X-Gm-Message-State: AOJu0YykhO3Vna7q8eTXld7bEuWZfC/Ng+7ENG6Episg43hyQ2/Yzp0S
	Bz/xwEVl+LZ1UlPPDRgRrXJe7XbqevHmM0m9ETnEsTEZoctje50q/NL+
X-Gm-Gg: AeBDieveVukMkqVBTtr0n54gmuKCKWFWImxFL8l5+UDcFE7Erb9npBf4pFJOsl3oFm8
	+2jnnW7hFRjnzrgfZ+/YgIPdveZ9lFgWvykHZTJEgfRSgF0DgcPhABgCyuZ4JaxJPd/zcf2JbDj
	TtllTXigE1j1Sb4FdIdnAtT7h8D8Z/NpbeGXnOXdbqtwliCWFmCwo6QhWPg2pUQFH57yVSu0ylM
	tAziFqYkzrU8OYEgPDVXpJhSOi8He2naraPLedJWI1rybapOP9l/L5juisgV/qLOdtoKDYN1+2z
	qEiDaQQ7rXvmm8dHDbs2jFBblnJUS3hhsypII0+c0TWkVQoUGs7/RbNYWhu3pp+X3+dXvRBXFnf
	HLiZFSBTu/R3//eoTkSJ6xpLzk6kyzv1DXkXZzLsHLUZyF9sRZzLI3a8FPY/wYgX+h7HbmlkWm1
	/x0/kdVJk7Y4rxOn3wzRFe9ch9mi4wi5kN0F+DuIq3egjPAUcDI3rNJCOlwKI7EfJfrq/E97fNH
	MPECW34Ww==
X-Received: by 2002:a05:6a00:2d9d:b0:823:cbb:a484 with SMTP id d2e1a72fcca58-8352d1716ccmr12539224b3a.14.1777947090148;
        Mon, 04 May 2026 19:11:30 -0700 (PDT)
Received: from localhost.localdomain ([2605:bc80:3010:503:f816:3eff:fe99:6bb3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbcfc0sm278508b3a.42.2026.05.04.19.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 19:11:29 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	willy@infradead.org,
	ljs@kernel.org,
	max.kellermann@ionos.com,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] PREEMPT_RT: Fix the typo in the comment for kunmap_atomic()
Date: Tue,  5 May 2026 02:11:25 +0000
Message-Id: <20260505021125.1941691-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `PREEMP_RT` with `PREEMPT_RT` in the header comment to
match the correct kernel configuration name.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>

---
 include/linux/highmem-internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/highmem-internal.h b/include/linux/highmem-internal.h
index 0574c21ca45d..bb71e7dba4f7 100644
--- a/include/linux/highmem-internal.h
+++ b/include/linux/highmem-internal.h
@@ -262,7 +262,7 @@ static inline bool is_kmap_addr(const void *x)
  * @__addr:       Virtual address to be unmapped
  *
  * Unmaps an address previously mapped by kmap_atomic() and re-enables
- * pagefaults. Depending on PREEMP_RT configuration, re-enables also
+ * pagefaults. Depending on PREEMPT_RT configuration, re-enables also
  * migration and preemption. Users should not count on these side effects.
  *
  * Mappings should be unmapped in the reverse order that they were mapped.
-- 
2.43.0

