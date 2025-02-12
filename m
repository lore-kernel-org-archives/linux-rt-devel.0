Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423E1876
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 00:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319402; cv=none; b=gwe3+IiwnuQ4VWKhcc5Tecs8PPr8OcNA9rU+sMsVq57bgzSZDm2cwM1cv9TN2fg4KKyfgIUaM2eiXwPNtQ07iF5aX8SAGEhCxFpu6XE94yennZpCB/TvTAeh/zlQnORha9nIbeUMBXHIOCMZRsBE9EhPfPkMNNtA3LxmY00ovHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319402; c=relaxed/simple;
	bh=vF9sAsivftSRk9YysN+Elnzfq9dO+3SugGtK1Qgvf6M=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WsCPyRKHDRovoiBHyt1UwPFg/ffCT6RNfA8rRT+HpCL+VQ+BM0VK3bz6ewgkM+gFn6s1+mfEUqfy/rDM8D1zs49DL64v9sKztQy7/cfgjRHIn38mlf0nzJzgp2s+iOMUDmRV37iwSjjcK+b0Uzxmc/1Bimy0gDDE1s7kWeLHMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e6jtlIz0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e6jtlIz0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739319399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Aw447gaPb7zNMocf3h4BtDlt/qfajgVcEdNoBnnrQDw=;
	b=e6jtlIz0wnxpH6L1mXKN3dwn5OWyz2fylwD9cLUVYimRYuQP2kILM5DrIxC25NvxPJbBKN
	3cRKMSF/3J8qCxenkP16yEQSiAmADijZizCki0PiJVXz+xH6oOj2iwnukJunIwAI+iIr/W
	ExcivfyiL0b/oMwgY/QTSKYKtP5oEkc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-w6Et90NjNvyJXz28_odlCQ-1; Tue, 11 Feb 2025 19:16:38 -0500
X-MC-Unique: w6Et90NjNvyJXz28_odlCQ-1
X-Mimecast-MFC-AGG-ID: w6Et90NjNvyJXz28_odlCQ
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c067ec2de7so53430785a.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 16:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739319398; x=1739924198;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aw447gaPb7zNMocf3h4BtDlt/qfajgVcEdNoBnnrQDw=;
        b=UJJtMB1JSHH51nTrQUy3DfFfxGRVEoqfOXkLkCLNMaBeTeHrAaEYobbDdcM5TJfjE5
         URZTFKTMiOac8BgRlp/y+3FmH1dlTkBDV7a51ptXh7M4ENdRBjNLEQR29tLkXN/rIHEm
         9yue3KC2uBHR4O2TjO5aCnzOsNOqqkT4vuGieZqspESjqxD/CVFkQcclbJ9P6Q+yaqtO
         zm++OFec7uLAO7UhBD3zmW7uGh4Ku/LckFsaYpkdCKL9ZG7Ji2n1jcY60MtBYf5ywKZT
         ohWxQmhYPOr6Z9IN4mOvNVBZwJYyEDNlh7PZUamSwaMrXr6wicFlOOe+uCfTVQiHxv2g
         EAsw==
X-Forwarded-Encrypted: i=1; AJvYcCUIqZqBayca0IPwgU8JESwbL/6XGPfgESLyoSauRD3+n8L+ik3frPIZrPIWuPCMv+TDPLAjp0uHvtYDh9RN2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvOcFhp5FPd7dL7iiM40e3s3y7nja1RBqdrabh7ynfEuLuxrMX
	AFsBOKZmRBjVV8nsq/gHNFAD8HRoUsKK1cTL/GukXc8iD7+57J5TD3Dn0K/t2RreQXIjEV1i4un
	mWkY7ViMSkzqyi+M0sjzceozJQdiaRnw3Z3vb0qLmaX30VrbSShh0AFYaAbbrssrC
X-Gm-Gg: ASbGncvqfWaDWfcrS1PXR2ejJFparu/L6SuqTfyZidwIrR1qKBEju10mlvf832KeiVI
	LsHoYv1Mc7nRbJX+8NdmLbEdvPyDqin7JvH0s9Ml7Jy7ziJgdoV7ijkKuLQIhawDs7BlG7IhJcP
	+puDNX1N1yrFbNYYYva88yqIHDehimLp5RVjNQqH9LBE/QqO/ONgXv7V4A8qQywq0uwX07X0vgy
	js0OQYwmvWo7EHSKBSsABkQEs9VpzCDf03HiC0bN7SMBVhQy6BQFVdFS8c59vY51N+XyCDuj6vH
	No6LOVJ5hzqhiE7vocOvL8OtPPViCdLVkcV+o1bR0p9se7Yz
X-Received: by 2002:a05:620a:24d4:b0:7b6:fdb9:197e with SMTP id af79cd13be357-7c07025941dmr154538085a.8.1739319398121;
        Tue, 11 Feb 2025 16:16:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENzMVSe0weoS27WWCT7JtaiNjOl1Kw02kBUwi9+QkdbL5XSwYfk9EZa1PX4HVM1t7uIloPkw==
X-Received: by 2002:a05:620a:24d4:b0:7b6:fdb9:197e with SMTP id af79cd13be357-7c07025941dmr154535485a.8.1739319397850;
        Tue, 11 Feb 2025 16:16:37 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0728eb208sm3484785a.99.2025.02.11.16.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 16:16:36 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <6b6c1245-f6ee-4af7-b463-e8b6da60c661@redhat.com>
Date: Tue, 11 Feb 2025 19:16:34 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kasan: Don't call find_vm_area() in RT kernel
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250211160750.1301353-1-longman@redhat.com>
 <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
In-Reply-To: <20250211145730.5ff45281943b5b044208372c@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XodVqezTo0jQtIy6DAGrjkxangcYtqPQOwe4TiNFSzU_1739319398
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/11/25 5:57 PM, Andrew Morton wrote:
> On Tue, 11 Feb 2025 11:07:50 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> The following bug report appeared with a test run in a RT debug kernel.
>>
>> [ 3359.353842] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>> [ 3359.353848] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 140605, name: kunit_try_catch
>> [ 3359.353853] preempt_count: 1, expected: 0
>>    :
>> [ 3359.353933] Call trace:
>>    :
>> [ 3359.353955]  rt_spin_lock+0x70/0x140
>> [ 3359.353959]  find_vmap_area+0x84/0x168
>> [ 3359.353963]  find_vm_area+0x1c/0x50
>> [ 3359.353966]  print_address_description.constprop.0+0x2a0/0x320
>> [ 3359.353972]  print_report+0x108/0x1f8
>> [ 3359.353976]  kasan_report+0x90/0xc8
>> [ 3359.353980]  __asan_load1+0x60/0x70
>>
>> The print_address_description() is run with a raw_spinlock_t acquired
>> and interrupt disabled. The find_vm_area() function needs to acquire
>> a spinlock_t which becomes a sleeping lock in the RT kernel. IOW,
>> we can't call find_vm_area() in a RT kernel. Fix this bug report
>> by skipping the find_vm_area() call in this case and just print out
>> the address as is.
>>
>> For !RT kernel, follow the example set in commit 0cce06ba859a
>> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
>> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
>> inside raw_spinlock_t warning.
>>
> Thanks.  I added it and shall await review from the KASAN developers.
>
> I'm thinking we add
>
> Fixes: c056a364e954 ("kasan: print virtual mapping info in reports")
> Cc: <stable@vger.kernel.org>
>
> but c056a364e954 is 3 years old and I don't think we care about -rt in
> such old kernels.  Thoughts?

The KASAN report_lock was changed to a raw_spinlock_t in v6.13 kernel 
with commit e30a0361b851 ("kasan: make report_lock a raw spinlock") to 
fix a similar RT problem. The report_lock is acquired before calling 
print_address_description(). Before commit e30a0361b851, this 
find_vm_area() is a secondary issue. We may consider commit e30a0361b851 
isn't complete and this is a fix for that.

The DEFINE_WAIT_OVERRIDE_MAP() macro was introduced in v6.4. So this 
patch cannot be backported to a version earlier than that unless commit 
0cce06ba859a is there.

Cheers,
Longman


