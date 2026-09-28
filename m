Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D364E56C4
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617313; cv=none; b=Ub8zIuMxeawzvPYX2UJCsdptMqLuraCRvFf3f7iZLBoZbCoK28y7AhChVFAaGniBWqbSJ9vUbviRLF+hwOeUC5ags1LHz38BM0LPFWgFH8crk0oHmia/5QX9I4VDsTiFpXzfQoM3ghuoD5fIIv58QO9xfeQ/hrxfrDx3VJyVMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617313; c=relaxed/simple;
	bh=oBxdLKzu1tEOdRfcRuf4qFtiL4lcXsW2YMerrRbbXZQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aApZ+xDcDQfBfPFmaHY6C2RswFC5NdMUVIkGfdrXUxqTYZsTgzyboUZlP72kaWxoxyINKuX93hwQSU2LWi0fgvSwQRwQAmJP7XY6KNExq52xX2BD3w7JrDxQdztHpD734hQQjTUb7HjnmMUTAp+4O/riiWbfL3yibGAXlM/5mxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IalIOp/S; arc=none smtp.client-ip=209.85.221.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IalIOp/S"
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4870142f030so2265841f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617308; x=1791222108; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/R3jIsuFxLI+ycNCkUkycnkKQylo65Jf0ypcBShLiJ0=;
        b=IalIOp/SgoeLqWTF0eP3XauH+HIT62U6C0xRJ1P+AvH9kdRZ0yBJFTC/1G5thILpsW
         ukrde9eM8aGeFgdrF+FKklVeHitjRaa4g1RXSxEuyezXWgcJueakzYqBBRN4vqrmk6RK
         TZPHVDZoWizkM/cUTYEFzr2i/nBZbF0A+5J2rqM8LP20pvnWBGMYG60seXTLZaHCCO/2
         9Qnz5jx2TEZmPH3KCjnjrpuyQ718V2YSPku3F8Om3GsqTIfgQEaQT4Luqvy2LsH/1omn
         LCbTZ93i164FbnEwtdUSgj+/PG0QtSdMlrLjXtnjLNSd65/iHdK+9uqNcPLPJqgp/Ffh
         NvWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617308; x=1791222108;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/R3jIsuFxLI+ycNCkUkycnkKQylo65Jf0ypcBShLiJ0=;
        b=RlOvLFoTTnj7/4bwObl3TbhHWoamHmin3Fh9dr8L3C++Fg5ygSnmGlvZZcyy7x5m0w
         ncDv4EvwmpBa7+VRz5CjxjGs7NYlQG9aGplTNhloJScd9oRWmstYSTLlEQra7AWNHK9W
         Jea6IwnB9aHDu80spjb/JgiGrcSEPZM+Hs9ALcCAnrmBv+ByFXjRclnje2WWJG2gxOgo
         H3TKpQymtKDoSjvaCC5opKpYHCpvTDOxqQ1AZgh+wRMuSOLXu20x/8dk8uZUaTc1qNSo
         ynGL4c8dsMDUHs45DCRgbD7X2fT+T07ItbusVwVUiPXBq6Q7mdBr4EPG9Wb1sBXSI/w0
         psYQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3qbx1SyJgLf+Y/yu1JhWTKJ5EMoQyF7a4agX2SLdc+SzLAX+gghfizFils7UYCB/Ivu+BN5/r5QXjvyVbOA==@lists.linux.dev
X-Gm-Message-State: AFuF++lWpQaov0sBezkPyJeMIctJR0861yaSbvyNp5ZNqp/2boetl1T3
	APj0sXY7bongGQxOPEcwpmwxZH/hcSzo0OeK50zKJDym4BMxp+GNgNO3MGizn1D388Od1QPk91J
	J4L7E5wQz0LCRuQ==
X-Received: from wmoy19.prod.google.com ([2002:a05:600c:17d3:b0:4a0:23b:31a7])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b1b:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49fe66c8a1emr263025785e9.2.1790617308191;
 Mon, 28 Sep 2026 10:41:48 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:08 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-2-smostafa@google.com>
Subject: [RFC PATCH 01/15] fork: Remove assumption that vm_area->nr_pages
 equals to THREAD_SIZE
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Linus Walleij <linus.walleij@linaro.org>, 
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

In many places number of pages in the stack is determined via
(THREAD_SIZE / PAGE_SIZE). There is also a BUG_ON() that ensures that
(THREAD_SIZE / PAGE_SIZE) is indeed equals to vm_area->nr_pages.

In the next patches the kernel stack size will not be a compile
time constant and would be less than or equal THREAD_SIZE based
on a command line arg. Therefore, use vm_area->nr_pages to
determine the actual number of pages allocated in stack.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[Rebased, also skipped intermediary helper variable nr_pages]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: David Stevens <stevensd@google.com>
[Update commit message]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 5ef413368912..2065693e762c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -315,9 +315,7 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm_area)
 	int ret;
 	int nr_charged = 0;
 
-	BUG_ON(vm_area->nr_pages != THREAD_SIZE / PAGE_SIZE);
-
-	for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++) {
+	for (i = 0; i < vm_area->nr_pages; i++) {
 		ret = memcg_kmem_charge_page(vm_area->pages[i], GFP_KERNEL, 0);
 		if (ret)
 			goto err;
@@ -488,7 +486,7 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 		struct vm_struct *vm_area = task_stack_vm_area(tsk);
 		int i;
 
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < vm_area->nr_pages; i++)
 			mod_lruvec_page_state(vm_area->pages[i], NR_KERNEL_STACK_KB,
 					      account * (PAGE_SIZE / 1024));
 	} else {
@@ -509,7 +507,7 @@ void exit_task_stack_account(struct task_struct *tsk)
 		int i;
 
 		vm_area = task_stack_vm_area(tsk);
-		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+		for (i = 0; i < vm_area->nr_pages; i++)
 			memcg_kmem_uncharge_page(vm_area->pages[i], 0);
 	}
 }
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

