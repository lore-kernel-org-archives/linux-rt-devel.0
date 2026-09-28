Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7618D4ED1B3
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617319; cv=none; b=f9cM1S4yH6tWbdE+fclT4FKszj3w7QCoFK2xerRK4jbQNFM08kbrGiSZJ/Mo187l7+yvWC6whYWzPBwf7Ywx9e1zv7nDgnMpM6yaZARqcytpJi3gq4w5Y54bSC8mPzBroWmIw7oP/h0jTegg3Rg2UTGwe1pTcyt1qQqaXhVS+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617319; c=relaxed/simple;
	bh=OjWnAwqkXs+i44MTqOp1Ck5J5mQ7pY35YplCenpi9Mc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAYCxw07Dq2TwdZTuS/8nU9w7Zliu4WM+zFwo11XpD/XjIGZgXBOuDU4f7NgVzCkYrIoxcEwio/yC6Ll3amwT9+xdQfFklEjNPi0sv0S1se4U8tVO8rUD+UN0NgbybZN0majLpIFLQMjVmy+xPUmGxTVMtbcsvnOU+LRjyzhVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyvi6sSe; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyvi6sSe"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48876f48669so2415274f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617314; x=1791222114; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jUO525MYjN5YsfP/KDhp3xMzNW05smVZVp3S7wkbxmU=;
        b=uyvi6sSel9lY0hGR6hnL0eIFGgG8V5ECY0veXXq+sHslgQGjOqvm99wdswwAqbjAu2
         gHQuv8p/y4Z8ubO0Ngn4+FsgZYux5PatEJdF0C6D6OOzOmS/nyeVEpnUySrfppBszxVh
         Z68rfIn8XsboTdnKZIxfWw5BRcW2vjpKwhghsnkdlYTCuFiQyTNZH8Q0183FJPCMG4Qq
         Weg3Y+rEXLos7wIvKbimT607JbQ3U1dN4o0KApCW6ZH0VAYRAJlbnz9q1ssCQ6GUBKna
         8+3w/XByJxxfjYNDl81eQrt8jrsvlSHo3a+mxwAibwxfKqYhzPa4bGv/tgQDI8VvKpLK
         u3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617314; x=1791222114;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jUO525MYjN5YsfP/KDhp3xMzNW05smVZVp3S7wkbxmU=;
        b=FNXV+926w91gQwV7P3eZLaKCgClaA+rSjvZkbYj6e8TZIyjGsrU3IpoaNbZFxZKx68
         Eb2KkqnRLzz6iZMtEL9LhoyRK5gl25Jhuzwcgwb5Sc+TkagfCUiROA2I0pj9vKQ0H/V9
         yydu7abtdauyb5FWzfmF82khhie11lMXo01fb/DZktXOuBEaUJ0ibN4t9Z3VoCUYr4Xk
         R+uNdm1cgjIGL1EMFpwRaWpNioKpYyTtkCqa4/K44Xkz3q6D0OwQdfivZtk0VuM3/2W+
         FjRJKYFE4u5t2f/Vy5T/8TSTCAyet9OfL9I56xrK6TGeZtUt7sl2OrfO+gqoJxeR85MI
         Fb7Q==
X-Forwarded-Encrypted: i=1; AKwUvBwmNvDfHytF5qZQVx2itQFR7fyUE1QNHXyEQ/UScWQFn9rXE0zVu7D3NrEKWymawVT898J0rp4nooIBSh54Mg==@lists.linux.dev
X-Gm-Message-State: AFuF++nZg/hbpdqBBexOqT7TrLBhAhaK+8qtEijzrsKtexYW0JjhhKfq
	N6x5FInOxuD/H/Xlu3kXyo/O/8WiNl2Laxa2Ok1kCH/gXrCfe1/y65gx2cU54iz4EugXJlVNSfd
	9ZhENyVMv2bvmWA==
X-Received: from wmgb3.prod.google.com ([2002:a05:600c:1503:b0:49f:fec8:8e56])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5487:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-49fe66ee809mr241216335e9.22.1790617314094;
 Mon, 28 Sep 2026 10:41:54 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:13 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-7-smostafa@google.com>
Subject: [RFC PATCH 06/15] exit: Don't assume the kernel stack size
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

check_stack_usage() assumes that the kernel stack size is THREAD_SIZE.
The allocated kernel stack size may not be THREAD_SIZE anymore, rely
on the newly introduced helpers task_stack_size()

Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/exit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 424c44a42a4d..899d3bf048d4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -883,7 +883,7 @@ static void check_stack_usage(void)
 	unsigned long free;
 
 	free = stack_not_used(current);
-	kstack_histogram(THREAD_SIZE - free);
+	kstack_histogram(task_stack_size(current) - free);
 
 	if (free >= lowest_to_date)
 		return;
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

