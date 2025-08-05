Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4E18DB37
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 Aug 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408504; cv=none; b=K0/ZgwOUpjusGItg3Z0PovZtLgI5xDXNEhHsxUuMKy8ztSegNty5vqn1t81QUzwE8iLFPrSpgYQRj1uHglRTlwUQGzcOUP4TrpBB3oLY2kMziVaQvCAxsc78XALaif6kVqVMJYy88emGNcm9k2FWECWlBCMAub5jrkXHCPVPRJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408504; c=relaxed/simple;
	bh=/yt3tHivUm51dHtkqDd0wR7z1y68m/D477BZ2GLOUAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD6nYge9j9umBI+8Fywnu7oFB5mguFChQyfybewliHVhPJDwRM2Oe/cUFlFBLeMvdu1a4j1p2MdtQlJkA7xsFnyJwQXIrk/YVDo8J8PyayXIrh3ltb60Rq2inFw+xoJdsEelaIMv4fUM7B0E5RrYum3LH+cEBro91tGY1ZcFNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2400a0c3cf7so8549565ad.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 05 Aug 2025 08:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408502; x=1755013302;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZMGhYD5OE1ylPdIIJZi93rO6zltU7tB53w2SBZXO9s=;
        b=MMs5pqhazRPooXHg+nqsg+3qfWG/5YYIzCHme/msCNnE7OAqtD8KJwO1JGXfIdgFx/
         E1uez0JvIIbsf9wyvxHP3Im5wD7PtSaMtxcev89Hy1Igg4AWUd+uNs1P5kGwxOxDKskp
         +VfdZyrvBKuL7OcMVIf7poBL19JUqURaFyvqwwrn5leKQoYYijY1wo0X6a3dF6yjs7iK
         x5w+7oJcDjmg9xKV7tMg/BJ0EnOR0fkmQ+Nnk0a3G2cMg5oZ5DdURMKc8czZqrCPpYsA
         yJbXqbz4gTU1I05fjNd26XwBl4N2XUB70FHCBdi1kx4OVljHqMQmxVgJ5OsmmT+HCQK2
         QXag==
X-Forwarded-Encrypted: i=1; AJvYcCXJJGMeXNSrdnT7XSa+GpbZ9urAPWFopZgchXKtjvrxgrKdkxus/L9HqrQIHLswnEy09XgreXoqEAdlmonf2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywcsjw1LHqxrLEC1BWnYCNZNbbbO8llEh0tUvhIND3T0HcWxoaJ
	Ig5w/1cH2WSvqZKzQHflFHe6DF7oSO/BqC3XVQiC2PMnfRqPA/1TP3rJ
X-Gm-Gg: ASbGnctFrxtamELwF57ERK5mBsVARatpXUuWjJY5iwAi7i5XcbvcyDaWma77keCkENR
	DgBEsPh+tsNlndhTf/yrYK3urbh+deSD5P5Ny+eXQC8sX6HtV15S98puxZbhRBukw6Fum8LvEsS
	lDyu9zU7/NfCAlBKE2JVCfvFDQFJqKF2W+J2XQgDiFITNsYx/tozXm78g68yNa/uPjH8CiAzXwm
	LZkRp9HvVg7GDM/MCdkPpWAW90Jl0IZicYoJeehdCKJ6qcdjgEhvXpET9oB7CqgEfDQuHOwd5Hf
	Djxv1ZkxCHBI8Ei6AB1B2RgBxKvVbOxTTh0zK8bljQaYoaIiuP+HbW2D7T6gj7asjmaIIAN7TpX
	cL0U87f4xZjrKeep3vjViACcHfbu08jwa
X-Google-Smtp-Source: AGHT+IFETrileTavzFogHlt3kpqW55YEJWqCTgysYCKWqbIjAeVGDBoRxanDjUE4RC0hSx+nzDcEEA==
X-Received: by 2002:a17:903:28c6:b0:240:63bd:2701 with SMTP id d9443c01a7336-24246f64718mr63253245ad.6.1754408502230;
        Tue, 05 Aug 2025 08:41:42 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89769fasm135540565ad.107.2025.08.05.08.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:41:41 -0700 (PDT)
Message-ID: <78384abd-7fae-492d-947e-c3311f952d87@kzalloc.com>
Date: Wed, 6 Aug 2025 00:41:36 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] kcov: Replace per-CPU local_lock with
 local_irq_save/restore
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Byungchul Park <byungchul@sk.com>, max.byungchul.park@gmail.com,
 Yeoreum Yun <yeoreum.yun@arm.com>, ppbuk5246@gmail.com,
 linux-usb@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 syzkaller@googlegroups.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250803072044.572733-2-ysk@kzalloc.com>
 <20250803072044.572733-6-ysk@kzalloc.com>
 <20250804123756.7678cb3d@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804123756.7678cb3d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

Thanks for the detailed feedback and suggestions.

On 8/5/25 1:37 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:45 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> Commit f85d39dd7ed8 ("kcov, usb: disable interrupts in
>> kcov_remote_start_usb_softirq") introduced a local_irq_save() in the
>> kcov_remote_start_usb_softirq() wrapper, placing kcov_remote_start() in
>> atomic context.
>>
>> The previous patch addressed this by converting the global
> 
> Don't ever use the phrase "The previous patch" in a change log. These get
> added to git and it's very hard to find any order of one patch to another.
> When doing a git blame 5 years from now, "The previous patch" will be
> meaningless.

I agree that using phrases like "The previous patch" in changelogs is not a
good practice, especially considering future maintenance and git blame
scenarios.

>> kcov_remote_lock to a non-sleeping raw_spinlock_t. However, per-CPU
>> data in kcov_remote_start() and kcov_remote_stop() remains protected
>> by kcov_percpu_data.lock, which is a local_lock_t.
> 
> Instead, you should say something like:
> 
>   As kcov_remote_start() is now in atomic context, the kcov_remote lock was
>   converted to a non-sleeping raw_spinlock. However, per-cpu ...

I’ll revise the commit messages in the next iteration to explicitly
describe the context.

>> On PREEMPT_RT kernels, local_lock_t is implemented as a sleeping lock.
>> Acquiring it from atomic context triggers warnings or crashes due to
>> invalid sleeping behavior.
>>
>> The original use of local_lock_t assumed that kcov_remote_start() would
>> never be called in atomic context. Now that this assumption no longer
>> holds, replace it with local_irq_save() and local_irq_restore(), which are
>> safe in all contexts and compatible with the use of raw_spinlock_t.
> 
> Hmm, if the local_lock_t() is called inside of the taking of the
> raw_spinlock_t, then this patch should probably be first. Why introduce a
> different bug when fixing another one?

Regarding the patch ordering and the potential for introducing new bugs if the
local_lock_t conversions come after the raw_spinlock conversion, that’s a very
good point. I’ll review the patch sequence carefully to ensure the fixes apply
cleanly without regressions.

> Then the change log of this and the previous patch can both just mention
> being called from atomic context.
> 
> This change log would probably then say, "in order to convert the kcov locks
> to raw_spinlocks, the local_lock_irqsave()s need to be converted over to
> local_irq_save()".
> 
> -- Steve

Also, I will update the changelog to clearly state.

Thanks again for your thorough review and guidance!

Best regards,
Yunseong Kim
