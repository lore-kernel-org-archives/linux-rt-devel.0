Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B6F2AEE1
	for <linux-rt-devel@lists.linux.dev>; Tue,  5 Aug 2025 15:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754408002; cv=none; b=t+h6/W42jVlUuJjFG5VWLkmml+iJx7og2trnzY3yJ3SBsDEyZvFTCw+jVT3bENxkZD1eV1+bkbDr+QVbA2pu48PG4tjk/jtEIaZzjwq8/V64KcyVSdTU+rYqAdNdv1Kk3wRd2SVg7G9my176mK8rBc7vUwpUwBorbkP0xW9PiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754408002; c=relaxed/simple;
	bh=eaNb6v/jyYYmzGGznooW2Go7ynSoEs7m74+LhzyQ2KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lffa4zL8p+ATKdyf/5aVmUo55rkHFHAzFiEIBv6jtaj/Ol0ZHM3q9ObP5gfjzSlOgEOc4nOEGudDqRi9YArGVqG+7f/WTr/odjH9bRfzyZk42Bq9gm0lAcgXXk+jziXcpcMQZKBCDj1l1yUOKYPfz0YgXM4zjBGjIQKzYwushxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2700de85d0so493896a12.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 05 Aug 2025 08:33:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754408001; x=1755012801;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yel2b+4RblLJvMRHPT+ucYyrlWej/tApR3MO/sdfls=;
        b=LgxahsqI0aTb8xyEVBkjqi2b9tlm+vopwPw5SQ2KNbWKLFtvs4/Pk36A1cCFQZ8pru
         KY7yHypLggO+o3iGW2oPV+M8PiENQ3OQHB7F+UF7C4st/4PEYvf2mrFc29C8yOT5VAtW
         Kzj13MlrPEjjOUhGL6qf4pBmNO9rI8f6TLaQZcLoIzgEMDGIFbbErb7Po/pRKYPrbzuK
         DI9eTwVJLGFiSVKP/YzSS7S8m+Z943Al7pmKYwk4VARGBsMGO9254D9kmQY5h56YB4YO
         Fj6er4kayS1D7yEcrMybzvSu87yT/m1KhtIYF5oZN/R6RjTmSYglPOeSXW4A00fhyYQ8
         V0AA==
X-Forwarded-Encrypted: i=1; AJvYcCWGCpyvitb2joUXvswGGAj4LkCPfCDKPxu4uDAT13Hvi+JblfGJAuXQtX5DJI033eM9d/N+W01Xx0BruSkqQA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxVtyTT4xyi5yFM2vFDMa4F2CuHMHWe/UZBFBm/+rmESKRDCL1Y
	GyPrBzuYWr5fCwJActnSkxaz9ksunZ4oKZh4k1HhXh6u3rTOqzeTekC/
X-Gm-Gg: ASbGncuQTKyjtHpDkklW/xnQrVIoALQPn22EpN621kdw/Li+gA0G3NULOrSpzya+Lka
	V+hhAEXy/6YsRBO0QpTV5IH30WMrbWADG4Br0AJh1KK6vn4KsSodClzWp5alYWITyBoafWUHuFG
	XbhqZgecW916HtBC6z2ufYuGlwi3ZKJZa3UKPoSzAyiVb0VQt1D5BzfTFFFFWTQRmJcm/jOtGq2
	teElXJR1o6GCGuUxw/95ELJn7s/57iVzEN6DvVEtK6sq8wsrFfSjrFSvcneMK+3Fhm7cP9gPRhu
	gloVPwXyBgzr7WqkmyUsBUDwIAGLywWBLybkvhOHMWtQnjlS2MxQkJtwKR/GsMSdeoBwjJhwe8q
	CXkwX6Kt4Mp94Io0H/eBD1ShCRBxztC6AdutmCZp6dWA=
X-Google-Smtp-Source: AGHT+IHULNJQv9btYgDl6fxqXCuB+doWn0u6Jk2OHizCXQnUCeNbkYhIJotgEaqwCog6LsLyr7rQFA==
X-Received: by 2002:a05:6a21:684:b0:232:b78b:cdc5 with SMTP id adf61e73a8af0-23df91ae1c8mr8645872637.7.1754408000588;
        Tue, 05 Aug 2025 08:33:20 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bfcb26905sm6454802b3a.123.2025.08.05.08.33.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 08:33:19 -0700 (PDT)
Message-ID: <d08de0fa-9dfd-4fc4-b9c0-ff181df8d459@kzalloc.com>
Date: Wed, 6 Aug 2025 00:33:14 +0900
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kcov: Use raw_spinlock_t for kcov->lock and
 kcov_remote_lock
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
 <20250803072044.572733-4-ysk@kzalloc.com>
 <20250804122758.620f934a@gandalf.local.home>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250804122758.620f934a@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Steve,

Thanks for the review and the suggestion.

On 8/5/25 1:27 오전, Steven Rostedt wrote:
> On Sun,  3 Aug 2025 07:20:43 +0000
> Yunseong Kim <ysk@kzalloc.com> wrote:
> 
>> The locks kcov->lock and kcov_remote_lock can be acquired from
>> atomic contexts, such as instrumentation hooks invoked from interrupt
>> handlers.
>>
>> On PREEMPT_RT-enabled kernels, spinlock_t is typically implemented
> 
> On PREEMPT_RT is implemented as a sleeping lock. You don't need to say
> "typically".

You're right — the phrase "typically implemented as a sleeping lock" was
inaccurate. On PREEMPT_RT, spinlock_t is implemented as a sleeping lock, and
I'll make sure to correct that wording in the next version.

>> as a sleeping lock (e.g., mapped to an rt_mutex). Acquiring such a
>> lock in atomic context, where sleeping is not allowed, can lead to
>> system hangs or crashes.
>>
>> To avoid this, convert both locks to raw_spinlock_t, which always
>> provides non-sleeping spinlock semantics regardless of preemption model.
>>
>> Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
>> ---
>>  kernel/kcov.c | 58 +++++++++++++++++++++++++--------------------------
>>  1 file changed, 29 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/kcov.c b/kernel/kcov.c
>> index 187ba1b80bda..7d9b53385d81 100644
>> --- a/kernel/kcov.c
>> +++ b/kernel/kcov.c
>> @@ -54,7 +54,7 @@ struct kcov {
>>  	 */
>>  	refcount_t		refcount;
>>  	/* The lock protects mode, size, area and t. */
>> -	spinlock_t		lock;
>> +	raw_spinlock_t		lock;
>>  	enum kcov_mode		mode;
>>  	/* Size of arena (in long's). */
>>  	unsigned int		size;
>> @@ -84,7 +84,7 @@ struct kcov_remote {
>>  	struct hlist_node	hnode;
>>  };
>>  
>> -static DEFINE_SPINLOCK(kcov_remote_lock);
>> +static DEFINE_RAW_SPINLOCK(kcov_remote_lock);
>>  static DEFINE_HASHTABLE(kcov_remote_map, 4);
>>  static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
>>  
>> @@ -406,7 +406,7 @@ static void kcov_remote_reset(struct kcov *kcov)
>>  	struct hlist_node *tmp;
>>  	unsigned long flags;
>>  
>> -	spin_lock_irqsave(&kcov_remote_lock, flags);
>> +	raw_spin_lock_irqsave(&kcov_remote_lock, flags);
> 
> Not related to these patches, but have you thought about converting some of
> these locks over to the "guard()" infrastructure provided by cleanup.h?

Also, I appreciate your note about the guard() infrastructure from cleanup.h.
I'll look into whether it's applicable in this context, and plan to adopt it
where appropriate in the next iteration of the series.

>>  	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
>>  		if (remote->kcov != kcov)
>>  			continue;
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Thanks again for the feedback and for the Reviewed-by tag!

Best regards,
Yunseong Kim

