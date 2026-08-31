Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E63485508
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193084; cv=none; b=jk2FYJFPH5kPt49WNDohcCTvIzicEFmFReaW0xT5r/1qXapG6kSj3AcY2+eO8IZJADMB/5XWArKnIYv6U/BWrbqlKYe8I6S4TZv2ajeJR/8Gspe5AX51eqh+HLTaeejB6dgMvfbMrvcyE3vHnZgdKCZ8e6aMSWtb6Z7hdPSJKf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193084; c=relaxed/simple;
	bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufOzuHIRP1DPopNLxUpQZ4K5IsRxO+CU4MImJ32jvchRUjuyEzatFszdilQLu0c1gPknYn3b9B3m0s9D/AK9cFrpzmG69A5/xz33RS1zqLfrmtO0i+kT/4Q7tQkSGsrJpySsXqkLWnJNAmlyPdj+GiYbLzXRz8R3BT+aUHbpXZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ErhGQGGS; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErhGQGGS"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-39647184c73so49622a91.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 09:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788193082; x=1788797882; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=ErhGQGGSykFnNBtxH3jIDT65O4Moj1zrLtyfq1O8y0jOiMd5DbDldqwxQiRIRGvaQ+
         ZxICfnegmLgywPK6TxsHoU+ovj0MzYP6K7GURL7HbElTndohzGYF6Utsff+gLnZwCQwm
         ddqQ1+xpJ5547Z+2ZIXMrdQimRNmP/hJISPbdUwT0HpCHFqCH00kmhshHbh/i1Tyml38
         7fiqmAJzVJlgTyI9DZsUkclCk98nKgPkqmp6TmtkkztCckYzCZdo5LoDYIJy/1PBFZ0e
         CE3ZISS+Qyw72Mmcbub5rWLdwhZLpsQYEXVC3mr1GzF6/dEOGy4XXXSBJQ7gPYxA6e6L
         x7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788193082; x=1788797882;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4wASPUEGd3KOv6Fdubi246q8cZj4P8D3ytyUATn9DWg=;
        b=K0Mz8Fp2fA8zMsZg2nwq7+ZHCKaVRSflRr8g5+lcFiYhFn1lJMdgNubAU+n/ur7XBy
         4SNnIs5yGRK7l8/hCQJ7YEittJK4Lo1uWGbVRkDMnGJE4zb0oGei81Fx6WYoPMXwsVRP
         y+6T7FAFj7x7Wq4bRZc6zGLNmemfzpwaFUJdQzI3ktiMIp1gajamaPFnrBo6LA96dcdf
         zpGeU+W4Mo86CVB4Se+f6kbKJKybJeETq66575ihKhtKMsnRmK5zJ92rBXNMwuH4CQ+O
         nWI0lM0VU8GhPeZ2XfMW0zhEfFZhy2QkgvFee7sqEtjeiX22L4aBGLf1YvBY+6ewlk3p
         4Q7A==
X-Forwarded-Encrypted: i=1; AKwUvByYPzh1FDZufb/UQGT9+QFK4VQDiQAUUVWPDbDfFkuKJOB0yBm6dzrSvT9UGI8C9Z8chfLlOaCz2A9LjYiRcg==@lists.linux.dev
X-Gm-Message-State: AFuF++lVueRUsyVFdCplitjmq6jHePRiMrJa/ypuimnSYDzTP+23DxfT
	VMwc4Y98vWm0YlZbppTI+i/RptO8fu0eiYYMK0orVFws9uXH/6dMfJyE
X-Gm-Gg: AYBFou1fGtSqHPEIwuiXkjrFRK7UtYWlPEa6FlNeIQReBA0hrhv+itY9f/8hzzzQXIZ
	6SJfmyYlU1Z8fQ1wfvRVRP7WyX4ODF0ZttAYGTROYuPODy0DxmFsEGNGw58jxrWPbXRsbEMY18G
	Q9nS6EKaDymeNelXRiqIYc3KUYLQ4qXGN7uJ6Lusi6nBLBSNh5nqBqHO7r0ZYJcunz8L1+nzyq2
	3Neqc9eMlMi9yW7ZSQ+yFgy5VhZQK1sXANBxgqUNztR97jUE8NY/EiQrbIhsPmFJoSPsaFxFlSh
	yrGTz+TuzE5IPvUmabUcQGE/NlVZnXCa0kbxQ1lh7SFxnGucmLhfqnzfQfZ90nwi4E5ZtTU7e53
	go93ew6Ovfz8EEwJgMrgW+4tuYARK8xUy7Fkwg0vyI1EKpjxLjAW5YeKeUHg8q5ZUSfIbERNZhJ
	CsmJ2Fxc8Xf2t390+lAU4tuMrAuM58cykogghEarkNqis2/uTRpTlVorcfEkMHJO94x1em48GP4
	XUdyTC3
X-Received: by 2002:a17:90b:47:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-398da5981f2mr7582035a91.1.1788193081897;
        Mon, 31 Aug 2026 09:18:01 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:21dc:72d0:a033:17f7:ad44:4f35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-398a2d45bd0sm5115099a91.0.2026.08.31.09.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 09:18:00 -0700 (PDT)
From: ThangNN99 <ngocthang2710.1999@gmail.com>
To: Vlastimil Babka <vbabka@kernel.org>
Cc: Harry Yoo <harry@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ThangNN99 <ngocthang2710.1999@gmail.com>
Subject: Re: [PATCH] mm/slab: don't use kfree_rcu_sheaf() on PREEMPT_RT again
Date: Mon, 31 Aug 2026 23:17:53 +0700
Message-ID: <20260831161753.7390-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <faac65a7-5c83-4a00-8334-ed26c45a8201@kernel.org>
References: <faac65a7-5c83-4a00-8334-ed26c45a8201@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks Vlastimil, this matches what I found and is functionally the
same fix I had in my v3. I built this exact logic (skip
kfree_rcu_sheaf() under CONFIG_PREEMPT_RT in kvfree_call_rcu(), same
dead-code removal in kfree_rcu_sheaf()) against commit 08dbfad3f504
with the syzbot .config and reproduced the original splat with
syzbot's C repro (writing "off" to
/sys/devices/system/cpu/smt/control to trigger the
__balance_push_cpu_stop -> select_fallback_rq ->
cpuset_cpus_allowed_fallback -> set_cpus_allowed_force ->
kvfree_call_rcu chain) — confirmed the exact same lockdep report as
syzbot, then rebuilt with the fix and confirmed the splat no longer
appears while the same code path still executes.

Feel free to add:

Tested-by: ThangNN99 <ngocthang2710.1999@gmail.com>

Thanks for picking this up and for the pi_lock/waitlock explanation,
that's a much more precise description than what I had.

ThangNN99
