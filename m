Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F973469F0
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755625143; cv=none; b=hgKUx2pqHSKGggfmCgFmlcCPYxHiRBwLlh4eyfzVvNCmZpG/nlPeJ32BkpP0MSfeix92TM3syQ75N530ITvUTcxMilUNVl6RhYYEwUm6swV/hf68NTMSxik6LCkzDbcwmcM3mdOJzL4rlexN9NdxuXrlwtQMtRte8GOWNmYLWAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755625143; c=relaxed/simple;
	bh=n5fZDRdhpblR94HQcrZl3tuMZof3rDV6okZIfBL90lU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RAd1vfWsebJEzZVKHSi1R5MzUydZySfSCXKR5vyitp932fwe4i3vCC4/WDjMq8lUBk6cYdCUvf4BZDqhChliOZk2bOjKODnmVrPdopaHPqtMetV8JNsHn+ZAgqYNT/ZSrlp7umyjaoID8UGvmQdH14LO1ZQUwu4k5/wvQLiS2JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3o8fPpG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3o8fPpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755625140;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G1lVHf9B3MwbthIpxwmrqwUHvb4qbpr6q9mIydElOc0=;
	b=R3o8fPpGl0GIjyv0sGbaks+tT2L3yRxQENcl1QBg3DV3+uFlwRNHot1/UQOaXyS3yhUJ/X
	ZaiGcYSoG5u/xXami5BI3IAe6mzgUXRanmbb+szg1ahzW1X2Sd+KIXdGIa1c4kzKRl6GMb
	65q8yNpdLFc4RIMW1WZ5aPN5+wOQ83U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-z0JQWlgoMb2v7S_Uf534CA-1; Tue, 19 Aug 2025 13:38:59 -0400
X-MC-Unique: z0JQWlgoMb2v7S_Uf534CA-1
X-Mimecast-MFC-AGG-ID: z0JQWlgoMb2v7S_Uf534CA_1755625139
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e87069677cso1598355485a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 10:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755625139; x=1756229939;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G1lVHf9B3MwbthIpxwmrqwUHvb4qbpr6q9mIydElOc0=;
        b=TML/+n9L3eFoqqOWDxWpWwbEU8CkRBmM2XLNmY/n4y4RYsau4AsDCIumQLBCncqgOB
         +VPGBIzXKYBnM7YIvrz7JGb40h31dEkNsM4tR8HBeUePVQtGcY7THYg+gWHpGYJtyRMe
         d3UC0qnUWTYlOL8lIYOB+tj8eRFwun5o8dgYnskB1TWMmxeyrX2pHUw0D0IF8nVcpyGn
         1VfrQPgt5ukXuloSexwtB3aeHdk+DUCnjaDk3szLjjTEMpFeHAB6jYYpVXCUNVBGqT1+
         h50ZcdKJkjfSaeRdX9MUpCeHCUVAntEHDkoPLQOLXP/duR3XW5F/DDcSSHsTtLLa/yL6
         S1bg==
X-Forwarded-Encrypted: i=1; AJvYcCUbGIfmZy0yuZ2KIrESx9EpaTONEgXPoP9SweGV6gf/09AqSFO0uZFvaKIwYwX+QJs3rX2rW2chWll1S9dEJg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8Nk+Hg6v7GuTpH49Vjp8pP1vJ/1wy3mr/TKRQUWxG9WFXdITa
	6iJpcEMPavxQOotG9nmc5+qYtwrCpf2cIgASHYNmGmZ5psr+DIkf1JKBoriZMOF2mMwO9DChr59
	k2ASSiujPAtF3iC4eQhE/ABF+MQGln0i26q2CNzjjn/KFvPcAhGw4JZE2nJhH5xh6Dmju
X-Gm-Gg: ASbGncurDcdF7fjxgjUTZL07e5aD7XsMu4v7IjfjXH7pA+qRzDwNzzrQgZ1m+rprkqC
	BhgSjfs6/ZvpoRoxC0tZ8tr1vC1zZUsfdFxOb031fzwNhJFV91ZbfZ14PhPXt7ca4X6/7sOEYzh
	Qabm2BAJH6B1wvt+jdeMIYwYb7Rn+IaWrKr6PtuK/0VCYkll7ztWZTMPLqe6CNqs9LQ+vi0/+sF
	kRpxR8od3/w+WrtqBE7blMUv4RTWUKSYUpEc+p0TuQzERpiCgyL+0AkeIQ1qBedme1EuKaknuoh
	75X1kx0X9kgSWeV1RD45zUk58om3Wrf1jMYyKpQSy854pDlXkIW+HIZqSoHGTMhpjDJ9mmyW+Fr
	04fb75cEFSw==
X-Received: by 2002:a05:620a:2683:b0:7e6:8f41:2055 with SMTP id af79cd13be357-7e9fca94459mr16665385a.21.1755625138680;
        Tue, 19 Aug 2025 10:38:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgQk4w8WKFv31m629AzJg48gzsT3wV9vO3Klej86l6vqDXynU+1bYT1HQpPIZsZ30MYOYE+w==
X-Received: by 2002:a05:620a:2683:b0:7e6:8f41:2055 with SMTP id af79cd13be357-7e9fca94459mr16660385a.21.1755625138182;
        Tue, 19 Aug 2025 10:38:58 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e1e15besm805438385a.72.2025.08.19.10.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 10:38:57 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <8f36131b-e326-4d0e-96d6-9067b6c439d8@redhat.com>
Date: Tue, 19 Aug 2025 13:38:55 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] Documentation: locking: Add local_lock_nested_bh()
 to locktypes
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Waiman Long <llong@redhat.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
 Clark Williams <clrkwllms@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 John Ogness <john.ogness@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
 Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Will Deacon <will@kernel.org>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-3-bigeasy@linutronix.de>
 <db8defe4-14bf-4060-803f-e8b09a941d42@redhat.com>
 <20250819100046.ymb_o7VA@linutronix.de>
In-Reply-To: <20250819100046.ymb_o7VA@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rz3P3-Md9_D55rfR28SUzQZvwYKK-hdlo82IfISKPv0_1755625139
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/19/25 6:00 AM, Sebastian Andrzej Siewior wrote:
> On 2025-08-18 14:06:39 [-0400], Waiman Long wrote:
>>> index 80c914f6eae7a..37b6a5670c2fa 100644
>>> --- a/Documentation/locking/locktypes.rst
>>> +++ b/Documentation/locking/locktypes.rst
>>> @@ -204,6 +204,27 @@ per-CPU data structures on a non PREEMPT_RT kernel.
>>>    local_lock is not suitable to protect against preemption or interrupts on a
>>>    PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
>>> +CPU local scope and bottom-half
>>> +-------------------------------
>>> +
>>> +Per-CPU variables that are accessed only in softirq context should not rely on
>>> +the assumption that this context is implicitly protected due to being
>>> +non-preemptible. In a PREEMPT_RT kernel, softirq context is preemptible, and
>>> +synchronizing every bottom-half-disabled section via implicit context results
>>> +in an implicit per-CPU "big kernel lock."
>>> +
>>> +A local_lock_t together with local_lock_nested_bh() and
>>> +local_unlock_nested_bh() for locking operations help to identify the locking
>>> +scope.
>>> +
>>> +When lockdep is enabled, these functions verify that data structure access
>>> +occurs within softirq context.
>>> +Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
>>> +does not add overhead when used without lockdep.
>> Should it be local_lock_nested_bh()? It doesn't make sense to compare
>> local_unlock_nested_bh() against local_lock(). In a PREEMPT_RT kernel,
>> local_lock() disables migration but not preemption.
> Yes, it should have been the lock and not the unlock part. I mention
> just preemption part here because it focuses on the !RT part compared to
> local_lock() and that it adds no overhead.
> The PREEMPT_RT part below mentions that it behaves as a real lock so
> that should be enough (not to mention the migration part (technically
> migration must be already disabled so we could omit disabling migration
> here but it is just a counter increment/ decrement at this point so we
> don't win much by doing so)).
>
> I made the following:
>
> @@ -219,11 +219,11 @@ scope.
>   
>   When lockdep is enabled, these functions verify that data structure access
>   occurs within softirq context.
> -Unlike local_lock(), local_unlock_nested_bh() does not disable preemption and
> +Unlike local_lock(), local_lock_nested_bh() does not disable preemption and
>   does not add overhead when used without lockdep.
>   
>   On a PREEMPT_RT kernel, local_lock_t behaves as a real lock and
> -local_unlock_nested_bh() serializes access to the data structure, which allows
> +local_lock_nested_bh() serializes access to the data structure, which allows
>   removal of serialization via local_bh_disable().
>   
>   raw_spinlock_t and spinlock_t
>
> Good?

LGTM, thanks!

Cheers,
Longman

