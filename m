Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C6732BF31
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Nov 2025 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971678; cv=none; b=W5AFR6MFoVq+IMy1j8CdWswAIv/53ZC0ukv2js9A9Cwv2myjB/4eq2XXWawuMzhKmg7zhiQTR5o60Q1NCEdybiLBIj8TLR3R5T8z0UCUhO8aeGYW5hLAh98fsReCqN3OyRVXTqELJ6SK7CpKpXKfkNg+awR8P2rh8cAPJeF5J3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971678; c=relaxed/simple;
	bh=yl+oslX8wXO1RMzv0DqKzC2S5J5LK9Sv9dWD7vhAgAM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Nds4regE0ruuHjjlidjbVKLD93k0rA3g6v3RTizWYN39Kh3/1BOag0rdvwUbQ6Jr42zRwskzyO6vyt+JtEZAsXFQnfdHzgNmz8ujI2AR+n4nVTxB4maU5LH6cnzAAw71VOtHUiF6cyAN2jpaUKWQyTH4B0p/XlVPCx9YoT1UzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FijbiEZd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FijbiEZd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762971676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
	b=FijbiEZd46vSeDwSvYBUxk3wafkUoH+Cv1oAAsVk1KrbmfCySsHlI3zt3VxmCM+zPS8fUy
	tJtGDmvKTyT8p74VG6fJBnmwQazbLEzuCB4Wdi1C9H0T+f8Q49KjUxKQOmBEaCFghaI0t8
	DsjiiCACuG1Aa8ySQEUy2WyVQs23xg0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-HHCTx2vlMwifay_1OBajWg-1; Wed, 12 Nov 2025 13:21:14 -0500
X-MC-Unique: HHCTx2vlMwifay_1OBajWg-1
X-Mimecast-MFC-AGG-ID: HHCTx2vlMwifay_1OBajWg_1762971674
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b24a25cff5so330831185a.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Nov 2025 10:21:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762971674; x=1763576474;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dJpJWnR6W2PauvB5c9FgPR6gGTYegkNj3iOoqqoWtg=;
        b=J7uOFnGSgDx/eHF9e6tbkvj5bW4NRVcyhvOJae4LJ+VR7n0zCUPK7uMFx6qGztcEh+
         3JwdGjehlG8YVJmRTv+5A1PGeJZMb5pUbgNTRc7JPwR/r4OQNDzYWZNjwnNnBJfKsP9a
         zEie7CGNQ5mgZiFJxPLj3drEcfPjTUk3OLg7xVSYSbPylPzg31L52KwZZH9gtBzSPZfo
         bfjEMky4DAg4L00iUtDaXt38OmQ5C6QzYJhHS4TyiHcK7EcIWvA6a8X+oekQIjMlSXa4
         Ab82a3FjdiNXhKtjM2eovREnfsjdCM0tIm4SsK+0KWbLaG8q3CD/4TiCVZJrmGYs2jbr
         /4fA==
X-Forwarded-Encrypted: i=1; AJvYcCWxGCKQiYUei10B7m02zMmsKoZdlPtNC0S1XY4VZU6LTSNo8v+BpVn6R49l2LQGocjxFZfkL6bRCmxan08tnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxkw6y4h3c8l+MvPutISeUVFQv4HbEwBG/20c4xQcbw+OjZooMJ
	GFJgdBKz9YjK703xCDGzeF2PedhHFQ7ia6a1sJv63S9y57oXM9OdtWbNTNjrT442vQIcE/9Ksyh
	+rWowNblAj7cHixI81nKiUN+JciU0ziIU+52VUv5AsWTM9QXAGzWOep0RNOEE9mvfg1Bi
X-Gm-Gg: ASbGncsO27b2SNfqwLRJNB5yp72cRegtKZfjjJ9bWzJv7OSBjZob9vGQGkFUdZvH7SX
	RYkjTdepopMNNQm4LSJdBZ7l9yX9cdIgoa6f8/9KsCYuK40t5YCReqWfzDrWRNQSbiXKSP+fHR+
	tDFSOon2t/Cx/S7xnY3fY0O/bq5sW5D2gHKvkn8XZoo6s33ba918KS76S3mztT/2x9EEFlWO8I6
	d5fgW5Svy2qdUPqqg2lLcmrUdHTcXPjgnFI+W+ux1F6Y8sJ9sFQwtrNAfHikuzK3NNeVrXbjJMd
	O/G18XJe0kSMev8nOvYCk4/NwDddPnNK6b+2MmoyB6DmOYwqO5M+mS72nMsciJQnHOqm46KMrMf
	ZY6FI6DB11ljOsvHyylJExqki30kksBBY+/Kh5RYMreC1Sg==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491393885a.66.1762971674367;
        Wed, 12 Nov 2025 10:21:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmk9lfZ7Dqn8dctjmk3Q6bmGkgKiuUiM1dIje3DZrti/tFNHBsEkMGCydCnh8k8ZsuTO/tAA==
X-Received: by 2002:a05:620a:3189:b0:891:ae32:d696 with SMTP id af79cd13be357-8b29b82bdaamr491389785a.66.1762971673918;
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85e0a9sm238798185a.20.2025.11.12.10.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 10:21:13 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <318f1024-ba7a-4d88-aac5-af9040c31021@redhat.com>
Date: Wed, 12 Nov 2025 13:21:12 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cgroup/for-6.19 PATCH] cgroup/cpuset: Make callback_lock a
 raw_spinlock_t
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Chen Ridong <chenridong@huawei.com>,
 Pingfan Liu <piliu@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20251112035759.1162541-1-longman@redhat.com>
 <20251112085124.O5dlZ8Og@linutronix.de>
In-Reply-To: <20251112085124.O5dlZ8Og@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: T4WvjLqZjYfUfOZfrtkYfZ0bJB7nB8UgGpJsRJIhcJs_1762971674
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/25 3:51 AM, Sebastian Andrzej Siewior wrote:
> On 2025-11-11 22:57:59 [-0500], Waiman Long wrote:
>> The callback_lock is a spinlock_t which is acquired either to read
>> a stable set of cpu or node masks or to modify those masks when
>> cpuset_mutex is also acquired. Sometime it may need to go up the
>> cgroup hierarchy while holding the lock to find the right set of masks
>> to use. Assuming that the depth of the cgroup hierarch is finite and
>> typically small, the lock hold time should be limited.
> We can't assume that, can we?
We can theoretically create a cgroup hierarchy with many levels, but no 
sane users will actually do that. If this is a concern to you, I can 
certainly drop this patch.
>> Some externally callable cpuset APIs like cpuset_cpus_allowed() and
> cpuset_cpus_allowed() has three callers in kernel/sched/ and all use
> GFP_KERNEL shortly before invoking the function in question.
The current callers of these APIs are fine. What I am talking is about 
new callers that may want to call them when holding a raw_spinlock_t.
>
>> cpuset_mems_allowed() acquires callback_lock with irq disabled to ensure
> This I did not find. But I would ask to rework it somehow that we don't
> need to use raw_spinlock_t as a hammer that solves it all.

OK.

Cheers,
Longman

>> stable cpuset data. These APIs currently have the restriction that they
>> can't be called when a raw spinlock is being held. This is needed to
>> work correctly in a PREEMPT_RT kernel. This requires additional code
>> changes to work around this limitation. See [1] for a discussion of that.
>>
>> Make these external cpuset APIs more useful by changing callback_lock
>> to a raw_spinlock_t to remove this limitation so that they can be called
>> from within other raw spinlock critical sections if needed.
>>
>> [1] https://lore.kernel.org/lkml/20251110014706.8118-1-piliu@redhat.com/
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Sebastian
>

