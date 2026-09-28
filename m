Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00AF4F30E2
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617321; cv=none; b=GehC7YsX2hHjqxunkoGe45cBsRtOkif231g7W021KK2U/7UvNj7JExOD3SgAzb4IcnJoig524aJPsBz+X9PwSzCCdMz24Ql6GGuwpZjp4+c3b8FyR5vaX3tdPaSuKdVldGHD0SpculhanoaLBFmOtI813Gi31/gKMHgAzOj/yko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617321; c=relaxed/simple;
	bh=fxbdyOtQyXxGPt9dE6qJI2lO85bbyV/d17xndfVGn+o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ivJSCyH6CEMJwdMm+FgjfZMfsOC/LkAHrKyB/y/oyLKBav4++wkxmFL/WZyUJq3em4wn34xLi6+IjoePuTUUVv0gSGbw6poRQtp0kda7jWfBK6n+UwqXKEMDi4myeXKSLqAbjuumP0+w55kotx7s9vTFiwB2xKwdVvuj7NpuZ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GEuLdpz5; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GEuLdpz5"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e7631c43aso34370395e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617316; x=1791222116; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ci6kw3U2QUuQ8iEQWyGnN3yV0fEIMUBiQ7ACCZCMmiU=;
        b=GEuLdpz5BKmb0rY3fSwhx8lri1dU2ArWs3IhFXqnXC3xozM593ze99kBX7Pm15cFnS
         woG03SWWdVwpeAIIoX9BhNN5y4TTRo3iRxPil+dtq3OEaWKn1pwLy0szi8ro4ZCsnjD3
         rWdAjp0eEaBMFksiz+qqkTH99mmCydkUMu68Pbcmp476mrEIYaiybkJTALeB8sJQsMVl
         oTAiYLA8CJksqxbSjC+RA/cxlPbaxytTij+wM5W3AKP6ULfYp7pYTwVvpxZD9d1wINud
         d+kSrbYthXGOPC+QFLgb1/zlltYWy5EnrkgYzY2DP95kLiS7JcKIlaUbvLJtxFDsoKQ8
         i/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617316; x=1791222116;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ci6kw3U2QUuQ8iEQWyGnN3yV0fEIMUBiQ7ACCZCMmiU=;
        b=LuWlVQWvKKMnyQOz4LJjKYy46iMwf0GCBmzP62COwYl8Vhjg3c0KLmxZ1fyDcmLrpL
         5Wn4tbPWZJBNVepV6vhn57qKA7LF4lyK4WWEosOa/AwhXmUI768jdv3FvqSKCpD/5aQA
         cOtq+WEI9L4iR3XqVR3L26AYpV/jLw60EbFqeHw0ZQJtYWLOACaYGMu7wmYpD+v2HGDd
         DBCrHsKrBdvmA2sg5jk3vrEgaW+FpzpkMjcEf4wMiB/HfOpgBxLRcsn5neKjGFDf1z+9
         D59PjEOyiCuXD7Ly5ZIbt4yLpAMpYGoZIkKwPRCo4yoDslv7DYfuyka0hKBHchfItC0W
         yrYg==
X-Forwarded-Encrypted: i=1; AKwUvBy/9a5RxMV6hlNAmZRmHbVx1SaER87n6ru40bY7s0JEjuH/i90kvVRHa8Ololh7vPSYU+QxLmFE+Whx/FtZpg==@lists.linux.dev
X-Gm-Message-State: AFuF++lCb/MA7UT2VxSAQxz1S6L/k1jrxJaojiNCguFVOa2qCHUqJbfq
	vtcefu/OTnZPnuJ/hk1ky+J/7WcQp4wf15SZZEY1JaJwSMrLQtO0fVs7USibAN3M5lsdb1jaw6D
	K346zslpAOn4J6g==
X-Received: from wmoz7.prod.google.com ([2002:a05:600c:787:b0:49f:e26d:37ea])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a16:b0:49f:eddb:bcb1 with SMTP id 5b1f17b1804b1-49feddbbe6dmr202116635e9.25.1790617315540;
 Mon, 28 Sep 2026 10:41:55 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:14 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-8-smostafa@google.com>
Subject: [RFC PATCH 07/15] usercopy: Don't assume the kernel stack size
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

check_stack_object() assumes that the kernel stack size is
THREAD_SIZE.

The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helper task_stack_{low, high}()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 mm/usercopy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 5de7a518b1b1..f31a42b9f9c4 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -36,8 +36,8 @@
  */
 static noinline int check_stack_object(const void *obj, unsigned long len)
 {
-	const void * const stack = task_stack_page(current);
-	const void * const stackend = stack + THREAD_SIZE;
+	const void * const stack = task_stack_low(current);
+	const void * const stackend = task_stack_high(current);
 	int ret;
 
 	/* Object is not on the stack at all. */
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

