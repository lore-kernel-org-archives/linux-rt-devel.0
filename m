Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E62638DEC
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711025; cv=none; b=cwM0AzMNbexGDpCqVkvbFoasS5QMLMjftJx01glZLiCRUUoW87au3TPiBHkdUeFe/G6s1rV2TfXc+vE4S43V/1/90Uw4A49jhjHpfXBjyVzH9lFKpyZdh58Vqz4iHr1dEk/88znoO71M9bzpdlteadF51cxNQq/605ICyf3J+Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711025; c=relaxed/simple;
	bh=DW75gGgwTrdEPrpl9OFcroYrBY2GtFLKUPL3CvZoIts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZPK/stYU5lKF73SP5T31XLf0Vscnxus51l3g6sl4Exo9S4Ul0i+VdFwAb9Dug5Yn49QIyUWo/s8e2bltOJWflgDKN582QeLU8haiEUyRWGMEh9mInW0LDR7HdcYtVLSIMSJoRedJgm6pej7bGhrIo+A00pGwJw1e1MwwdZUoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR2jMFWo; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR2jMFWo"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1544241a12.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 08:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711024; x=1735315824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ae4oyfSl9VHq0GUA10t6av6eAE8uuVk00WqNvGV6qA8=;
        b=cR2jMFWoWroctNRN8IVziz53uOIkpyDYWEPize9ySupGIQky6dqAs2A5hIWQ0kHfl5
         pBuB+LQVPCBIHNMIZRa1vRE6zpHbM4W6bQjlYBFv/nVowAJ5oPVBYP/NL2K8HiJvHKoq
         L4aFQixNqo0IrmUfUEdonAtBn+/kpE0mT597NvuatBhJE2hXsuOhifjllSu+LJPo9uXl
         70V4zyGwno0N5wMVL4XR2lS5FyoNzlX5f1CLRVjAW3OYmjDuyp6H+yhXCUNSIp2WGKn3
         xvWLMIOGUBXAfKV/UvTocjZ9h2lIGfYkb/7ZCCJQf3TaXAjvj+myc91hPEfhkY3xxN+S
         yL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711024; x=1735315824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ae4oyfSl9VHq0GUA10t6av6eAE8uuVk00WqNvGV6qA8=;
        b=O58S5Yy8Z/CsoZ3qyPP+H1e6XTs8C38dik4CQjac7wfm1jmYQOAnohPfCc4+AhU5Xs
         9q9N78DX6W3CsTo0s7uVbj1QdDWHjbK9zfivhjiKVI6wh8OHGBkVeXCL/Vo4jMUiMALI
         0915FPsU57VsQMJRAv55k5uGqzBR3vbJNq6zGV2nQNDdWtCH9GFIWunS9m+TPK+nN9+i
         vIWNYjUgmTLIytUXa3Mmg2uBYIhlKIW3tbEb928rKFxJE3SzU9Hsf2eIhEbTOat6G6lg
         sMZKuTlh301+bMiCnUl++dlx3aNgAfw3FDb4bhSGeAyolG8RNuhTdsK0sKQGISgVYhT8
         CTag==
X-Forwarded-Encrypted: i=1; AJvYcCVst9yjesyQ2aKYfgAAP1ZVXsFCL4qO5EiayME7tafp24vbNJO8m3vrkmkorX/BnzzcKV5myZTukNBf/pQN3w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi2uCifHUmd4tl3LvzYpi7S+TAinRG51c5UI8e4fQ5JxXHHouf
	7q8U0R/pFSCBVgQm5FYbHZ+UY51wTp6e8LL4iOa9mfRHOQhUNkUI
X-Gm-Gg: ASbGncsDbQkdoqkTvS+13tDMvBIBDwTlNAqVv9tCkJ2gNO5CXJ0ibmLt8CO6YFUQWXF
	h9QCjuN4eXQK/hNyimJjrDBqKanC2T4vV94dDJUC3Hyqzjy+3jDCSIw127D8tCWr6gsuuNS6m4T
	/F767nymoseQiIBU8n7djFvM5CiABrw/2rrlmjOCEw71xWtaxPRDJPiQG1hDqIkCqUjXdArkbKl
	S36kKD0rQSrvvBgr82mcuJzxrnn+zL4McEjECzXqj7efpG51vlPMcWupmyi8Ct9ok5HegMw8heP
	/1/to3ZVBRVWJOBKgjKfJXOKcAJcLn+p5wd39SnL2722TDMuB4QR01LEn/M=
X-Google-Smtp-Source: AGHT+IE586Uv/A/CdK91Ddl35OLRgh801uOnKRMHq4t0wZO18hUk6rT+mrEr8OUFSaKa1XaCjjZwxQ==
X-Received: by 2002:a05:6a20:e347:b0:1e1:f5a:c027 with SMTP id adf61e73a8af0-1e5e0846a43mr4766817637.43.1734711023665;
        Fri, 20 Dec 2024 08:10:23 -0800 (PST)
Received: from DESKTOP-NBGHJ1C.flets-east.jp (p10213112-ipngn20001marunouchi.tokyo.ocn.ne.jp. [153.220.101.112])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad835469sm3407738b3a.60.2024.12.20.08.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:10:23 -0800 (PST)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: boqun.feng@gmail.com
Cc: bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	will@kernel.org
Subject: Re: [PATCH] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Sat, 21 Dec 2024 01:10:16 +0900
Message-Id: <20241220161016.422991-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z2Sdv6tSEoxiYW4e@boqun-archlinux>
References: <Z2Sdv6tSEoxiYW4e@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 19 Dec 2024 14:27:11 -0800, Boqun Feng wrote:
>The following is the rough idea:
>
>Regards,
>Boqun
>
>----->8
>diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
>index fc53e0ad56d9..7191a753e983 100644
>--- a/include/linux/bottom_half.h
>+++ b/include/linux/bottom_half.h
>@@ -4,6 +4,7 @@
> 
> #include <linux/instruction_pointer.h>
> #include <linux/preempt.h>
>+#include <linux/lockdep.h>
> 
> #if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
> extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
>@@ -15,9 +16,12 @@ static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int
> }
> #endif
> 
>+extern struct lockdep_map bh_lock_map;
>+
> static inline void local_bh_disable(void)
> {
> 	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
>+	lock_map_acquire_read(&bh_lock_map);
> }
> 
> extern void _local_bh_enable(void);
>@@ -25,11 +29,13 @@ extern void __local_bh_enable_ip(unsigned long ip, unsigned int cnt);
> 
> static inline void local_bh_enable_ip(unsigned long ip)
> {
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable_ip(ip, SOFTIRQ_DISABLE_OFFSET);
> }
> 
> static inline void local_bh_enable(void)
> {
>+	lock_map_release(&bh_lock_map);
> 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
> }
> 
>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index 8b41bd13cc3d..17d9bf6e0caf 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -1066,3 +1066,13 @@ unsigned int __weak arch_dynirq_lower_bound(unsigned int from)
> {
> 	return from;
> }
>+
>+static struct lock_class_key bh_lock_key;
>+struct lockdep_map bh_lock_map = {
>+	.name = "local_bh",
>+	.key = &bh_lock_key,
>+	.wait_type_outer = LD_WAIT_FREE,
>+	.wait_type_inner = LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
>+	.lock_type = LD_LOCK_PERCPU,
>+};
>+EXPORT_SYMBOL_GPL(bh_lock_map);

Self-tests are now all passing. Thanks!
It looks good to me.

Sincerely,
Ryo Takakura
