Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2003618DB01
	for <linux-rt-devel@lists.linux.dev>; Sat,  2 Aug 2025 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754172108; cv=none; b=oLG1TvlroDnS3ZQV1AFJnieUt8jOCCLepoiH0um+mi3BXlBSvqUiito7fzhK8u8jhrv5fi9qMb6uyTQXYdukIawy+sdtXAo1EV3m67fvLSWb+Lor/fEdKENcnFfxsTz7uYyakjV0XuBWtxc6GimCqyogn+ek6Tn8xtgNbV44hUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754172108; c=relaxed/simple;
	bh=h9dGsWgUYDzbbkTsgtBfXOsJHPWKtsMwDEyJ1+wQ6/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEbmiIB796ZggjEmMu9Uy10Az/kAunCMTpynzzy1aUO8jiI1GxSb5lROAVO8hOphjajmsNrjZg2errMhYo8i4Dfqhiw4zGjb1BdlC2lCfDMVYDpAFA5CA919XfoShp/e3CqnOAZK3IlKyaoRVlC/Q5EaroVCVug+r+gz/5HLuQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3510c22173so380975a12.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 02 Aug 2025 15:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754172106; x=1754776906;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6iKlbJNv1rMzXvKJJrDKnOLYsLImNj0w08vdZLLiFg=;
        b=FQ8BFINVaYUhY6WRxSg+uucWJS2ksOT6ry5xyDfADyVQGzgwNbQpfKBF+3qwL7P9Lw
         iHe/Ac4ioCJgmgplcJmp/kmO5II+ExlNm9fbaCqrqoLC5a5YaYT7W8ubJBDIjpLkLh1R
         JFOA7dl6KVj6MafPRBliklKnHehN8y6mMBJZgKPSNskDejqIiF9hhX2QHyL/SDApqdKA
         mOWqWZfmfiPt/XXIkLAj2WdVQdNB8mLfR/KWxqg3Jph5KLqAJao7/lrYfV4nZCBthVL2
         XQ2qA/OAOCBOHJNkNzcKNxVXf7lpHDuvDLxy7Om55vRoqnpHUcr5RdePkQpEBiLGc6ZY
         0n6A==
X-Forwarded-Encrypted: i=1; AJvYcCU2HmdXceEuOd5hUfO2LaMqy49vFIFozVC+EqT+ygqRJqcKAYLqJnDDTDB9J9iRT0rNpIIZysXV8VAL4ExK4A==@lists.linux.dev
X-Gm-Message-State: AOJu0YzoSLx5h9juzgfRuHv0/eWlhhkQQxfHYaSUmdRnQzCfPA8bnLUK
	c29mqyLnvhm8qkyagwAGZJdb/DeSSFNnWISVEJP2xRBJQHSYEHv69gzb
X-Gm-Gg: ASbGncswW8v/MD38pjvkvjP5B98mpml3QG3sbWI17SACk1YU1K53Sk/DYc0Di5UbUQR
	au9nYFc0IL2dzg57rueO4Zk0x0/g7JhAfPtQhUgKOOMXlFvMzNJBaMEU1QM5ybV1sKSPxk4wL49
	rKsmc3tPAIOYG8NShJz9tk7TT2XpZ9Y8+2/O+eRrt5aZHl838nB6Vz7QlkN9GYx5nR+C5QQ0c9N
	7anHnelPjl0kh+UKHTL0B0fn/t6uqxuAoFJ0Qbnjp329i4n0CxA1OvOYBLKXwQifSX8hH0MkS96
	jOKsQCxF0Io6BJw7xjSjxowkNqu98ZB37K5hf6djBpswlTDJomZ5fPn7akEMzh9wjYzGUjlpc0k
	tXrsT3EXpF6THGu8A8QVG+K/mUwSZPIh0
X-Google-Smtp-Source: AGHT+IHvFcjEaG3YxGtNa9QhNQdWOb0uhOSD/6FpInnGumGJtTNEwHNQrEi6gQ/F60yhksDGX4hFmQ==
X-Received: by 2002:a05:6a00:4b52:b0:736:4d90:f9c0 with SMTP id d2e1a72fcca58-76bec2f5dd1mr2171800b3a.1.1754172106326;
        Sat, 02 Aug 2025 15:01:46 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbcfb6sm7056787b3a.79.2025.08.02.15.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Aug 2025 15:01:45 -0700 (PDT)
Message-ID: <4a505533-b725-4e3f-94db-3d261937ea25@kzalloc.com>
Date: Sun, 3 Aug 2025 07:01:40 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kcov, usb: Fix invalid context sleep in softirq path
 on PREEMPT_RT
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Byungchul Park <byungchul@sk.com>,
 max.byungchul.park@gmail.com, "ppbuk5246 @ gmail . com"
 <ppbuk5246@gmail.com>, linux-kernel@vger.kernel.org,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Alan Stern <stern@rowland.harvard.edu>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 stable@vger.kernel.org, kasan-dev@googlegroups.com,
 syzkaller@googlegroups.com, linux-usb@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250802142647.139186-3-ysk@kzalloc.com>
 <2025080212-expediter-sinless-4d9c@gregkh>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <2025080212-expediter-sinless-4d9c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Greg,

On 8/3/25 6:30 오전, Greg Kroah-Hartman wrote:
> On Sat, Aug 02, 2025 at 02:26:49PM +0000, Yunseong Kim wrote:
>> The KCOV subsystem currently utilizes standard spinlock_t and local_lock_t
>> for synchronization. In PREEMPT_RT configurations, these locks can be
>> implemented via rtmutexes and may therefore sleep. This behavior is
>> problematic as kcov locks are sometimes used in atomic contexts or protect
>> data accessed during critical instrumentation paths where sleeping is not
>> permissible.
>>
>> Address these issues to make kcov PREEMPT_RT friendly:
>>
>> 1. Convert kcov->lock and kcov_remote_lock from spinlock_t to
>>    raw_spinlock_t. This ensures they remain true, non-sleeping
>>    spinlocks even on PREEMPT_RT kernels.
>>
>> 2. Refactor the KCOV_REMOTE_ENABLE path to move memory allocations
>>    out of the critical section. All necessary struct kcov_remote
>>    structures are now pre-allocated individually in kcov_ioctl()
>>    using GFP_KERNEL (allowing sleep) before acquiring the raw
>>    spinlocks.
>>
>> 3. Modify the ioctl handling logic to utilize these pre-allocated
>>    structures within the critical section. kcov_remote_add() is
>>    modified to accept a pre-allocated structure instead of allocating
>>    one internally.
>>
>> 4. Remove the local_lock_t protection for kcov_percpu_data in
>>    kcov_remote_start/stop(). Since local_lock_t can also sleep under
>>    RT, and the required protection is against local interrupts when
>>    accessing per-CPU data, it is replaced with explicit
>>    local_irq_save/restore().
> 
> why isn't this 4 different patches?

Thank you for your feedback on the patch. I’ll split it into four separate
patches for v3 to improve clarity.

Best regards,
Yunseong Kim
