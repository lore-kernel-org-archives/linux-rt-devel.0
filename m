Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079284E020A
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617315; cv=none; b=qZ2muGNBZzfs/HYTBzg7DqcB2d9IjJwk9fyUnuQacrcJ+jwAFFJM9MFaT5V8cDMXQQNuaHC4eLiwhb5jmmqIioX3RVCS5/57oA/69OslAjvCzCtWRhiBalSmWuGqO8+jFJSiuAGL4b6ChfATD8I3wPY/M6kyXn9vq+Obbz3142M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617315; c=relaxed/simple;
	bh=4i8baIAc2dkPaONbaLPORXqEKtv4vzfNmgQCV2XNs9M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ruxAZ3r19J/iYAmmFJBmbLct6qjSFt0sRzLdXpIBMo2OT1edocQGZwUOkHbCSbKayMdaqYVQaRETFx9w2QBHVhY57Ow2EimTx0zu+EFucjnoUqWh25F7sjUzMOVKxC0aXHh7ce/dzHghtxIUzuj1oN/PKs3RhCpx27Edcfog3Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aA0f1Ovl; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aA0f1Ovl"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49e6ba4abdfso35202745e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617311; x=1791222111; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZMttkoCzeXLC/JEGKL20pI+XNOolXdLvFIFeMj04zLo=;
        b=aA0f1OvlFvfHzuA8Nr/Y6XAj1eUcHFoEdCNaB7SQzSOFGdL76SsSweEah6jWv6gwUr
         MNHj/OKS1GCql0674JmUl22A+/15H6PlpPyub4ECZMcJRtjrbAY3bdBVNt793SygQFUk
         xf93ThojbH7vCWNj5G3PwHBM72XAIm9L/sJSq/bPoJJKxKifmU+RUNax71JgZ+n/NCHj
         RGFPEQSjIAU70zg/Dnw4ComlQ1tsOsxT47EJM2MUniR47qfunoET5QcAxMfCCc4yWjKK
         mTy2orJsItaekDTZGMV6gsAk2ypKRAb9U1uQHmPj/x+H8SJVO7eOZ9RyCnZgI30sW0AG
         KV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617311; x=1791222111;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZMttkoCzeXLC/JEGKL20pI+XNOolXdLvFIFeMj04zLo=;
        b=W0IletVuLhDSqjz5N+jct4pmgNeRBO1q5RnxZmkUw0cahqgmaUr0QgFtMwNCkpdyl9
         vrNvKPkh/xVk5Q2b+L5JJF8U/drtn7lZXaQUD0TvOj26QpBR1FUgGGAti1JdaZxtw/Gx
         qnzf1bE4f2uXv6O0+GC/WImaffhwXuxqNUV6hdNY2U54CiAaBJaaClfS5pUkhUQ7S7Hi
         y1I8a/lZ6P+5xwE4X7uq63y0ABrgPpGdsHNfpKcgLaQ/I0PtKkWBCkRcX9YJQbnP+VwT
         yzGTBs7jh3G0jZ/2nl6R7XpEV/A1c9yhJO02VUFWjmLCiFTRMaO29Jo/Aq0rzw2M8vkI
         5C0g==
X-Forwarded-Encrypted: i=1; AKwUvBwEyvuF0DkWh69wPb75DAaU5hP9tYLf3b4Pix4uYjUWtLYXs43DYRbsvOtrpdUX5ehtZ735as3xNnMQH7WDHQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kV6tfTry+3AAUjNAjknssQbCnIF7lCQPe5oq0jAnq8nttvrHgr
	sMqawyGGkWtiYOGedh/N4sylSKaC1WGmItWG9Cx1o9KJ7s0rIAtXKF1KdZq4qD/gt31nECRfFvA
	FrjlHgi7chJ+eSQ==
X-Received: from wmqb10.prod.google.com ([2002:a05:600c:4e0a:b0:4a0:107:e5c1])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b4c:b0:49f:bd3c:bc16 with SMTP id 5b1f17b1804b1-49fe66f4c16mr231430235e9.17.1790617310870;
 Mon, 28 Sep 2026 10:41:50 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:10 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-4-smostafa@google.com>
Subject: [RFC PATCH 03/15] fork: Move vm_stack to the beginning of the stack
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
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Stevens <stevensd@google.com>

The vm_stack struct used to free stacks via an RCU callback is stored
directly in the stack being freed. Make sure it's stored at the
beginning of the stack regardless of stack growth direction, to avoid
faults on partially allocated stacks.

Signed-off-by: David Stevens <stevensd@google.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ec4431bf309a..473878d7f62f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -285,7 +285,12 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
 {
-	struct vm_stack *vm_stack = tsk->stack;
+	struct vm_stack *vm_stack;
+
+	if (IS_ENABLED(CONFIG_STACK_GROWSUP))
+		vm_stack = tsk->stack;
+	else
+		vm_stack = tsk->stack + THREAD_SIZE - sizeof(*vm_stack);
 
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
 	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

