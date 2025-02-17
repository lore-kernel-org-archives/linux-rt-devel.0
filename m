Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45028D528
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814994; cv=none; b=YF08twnPwWI9bskTXgIC4tWWwKvncHPsxy5upBIZVmqjCm7nHJHKhwq1AwuN+1uWYPaKXihWjdQRb35QPVN0zARZqReFXDmAQe4sNynl9rkl46kGPy83H2z4lMtjH0EUCcUhRmemA9Pmd0RD/Glcr8P5niD6qJU1SxBSdWFTKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814994; c=relaxed/simple;
	bh=zE9veftWabe5c1OeAd736Vhg6Lh9Ujaj6TI7WKjzoaM=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y6yDRNiu5gTeB4jwOvdk4I/ZHZdo5G2fwwpuAbfAzHl3f72lGbaiX9tQPMNDbFMz7EYsFv9diBrtMh747RU/eEevGzzRbdv1algoYhgXOBKsuCQ+51/048A+1fKetKZCR/uCBQrYC1ICmzYxs1Lz0W+hn5KSlSYUnkelfFVIf6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WCrnVbQc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCrnVbQc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739814990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=niJ7GrqnlE8mjwkLXdroJsmq3cDp8d9woXPb/vSi3Z0=;
	b=WCrnVbQcTV/eozXWciyLZlftNUJ+Ysd8NMDgwNzoikzUGijp69FfvkVAyYXYm6AnqnN5kt
	R1zsQE2Xrc9gFWbmrVxUN5LJ5IdWymEtAl3lv07Z+R3hRyHp1AJXglEd+YEe8Duo2HmST8
	plR9fn5+dm1VEIE86tXVv4WnFowTnEU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-h80GGnDCMIWgyvwk6ZoiOw-1; Mon, 17 Feb 2025 12:56:27 -0500
X-MC-Unique: h80GGnDCMIWgyvwk6ZoiOw-1
X-Mimecast-MFC-AGG-ID: h80GGnDCMIWgyvwk6ZoiOw_1739814987
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-471f4381c1eso19216131cf.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 17 Feb 2025 09:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739814987; x=1740419787;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niJ7GrqnlE8mjwkLXdroJsmq3cDp8d9woXPb/vSi3Z0=;
        b=gTBDoMfASgj05SvQ+618O5VueS31jbX0hVzbVxjITvgpN+opVq9jWcPRU6Q6G1PD2Q
         RM+7SZBrAf8BA/In6ei8iVpbZj2Rdf7CFbVQ/5gBCf5T3xSp02bVZo9EwWtwGr+My++E
         kx1bI+WpBQQf75rrZesJ5FlSIfyvMOJvWoK+4zg+tKFDOZe2Pu3MsRdhPOx3tILq7ZYb
         03o3hXa4KuTNAz7dif9qwkocjoLWi3MdBUIo24vfoy2t2uASdqvREn6ifGT/5Md4C4uy
         hCtKkpraoGBo36t6Agnm62CCbHGSsd/VVL9g1X6BBUI621JBEG+XLHkHeHgPcY0k+PbA
         vxFw==
X-Forwarded-Encrypted: i=1; AJvYcCWE4y7KXua/LiXuOsfY4MYS3imkP4Q4cxKyrSGQY9fhh0cPgcQfeqzfyfD3wxAkisUa3C0EtKWPoyAHVLNA9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAQdtALwTJ1NmlKpoGTTcKo1jkMEjF96nrVLOnqH1XZpv+P2fW
	dgUZczYMTjuMxa1INru7GhchzFUo504uKtTpJwDZGv+e6wxPEivoIkA3D7CAZYhQ3zbfpdDhtmq
	4G6D5tKMOykoxXRQKgs5ZZswjbP0CPNdS02XO64GdMTXA7GEMma1141EQrPnOlhl+
X-Gm-Gg: ASbGncuWNZTZ5nfHfdGkGwE5Hd3fO4zQboGd+6nwAobAV51cwDp6wsZdLSrjmKNMa1V
	9CbXgfWodBNh60qEbVOyY8r3tLQwsG65X+vX6TFGJNnrpb64CXbuIUnvLbxrHcjsjLpcO1ZMR0/
	856qvuFLdU0jI2nvVDnspHlWlZ7Oj+Bu0BMrfFwliAygbRbJ7f36jrtu7VY/mSIbVKhQlidJBYF
	ItBCS9jTw3aZlnQWvPwHVyV5GxkP+qQbpG1hpTlJl0lanrU/OYYjBpXbHVjY4y6iEdd7hb/skzF
	abrzZlIntFfGCvmDx5aFoqJ/6lKmBvza3Z7ZWb9qwjHDDc/F
X-Received: by 2002:ad4:5f8b:0:b0:6e6:62e0:887b with SMTP id 6a1803df08f44-6e66cd29e70mr149586916d6.45.1739814987297;
        Mon, 17 Feb 2025 09:56:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMaH0te3WvqMwaIP410mOdgQto6F2VrfNkiVPnhvou7kFgzG16oJDSLaT8GWZZ/9EJy6ockQ==
X-Received: by 2002:ad4:5f8b:0:b0:6e6:62e0:887b with SMTP id 6a1803df08f44-6e66cd29e70mr149586706d6.45.1739814987028;
        Mon, 17 Feb 2025 09:56:27 -0800 (PST)
Received: from ?IPV6:2601:188:c100:5710:627d:9ff:fe85:9ade? ([2601:188:c100:5710:627d:9ff:fe85:9ade])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f46a8sm54068316d6.82.2025.02.17.09.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 09:56:26 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <d9c96532-9598-426e-a469-dafd17d47a70@redhat.com>
Date: Mon, 17 Feb 2025 12:56:25 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] kasan: Don't call find_vm_area() in RT kernel
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Nico Pache <npache@redhat.com>
References: <20250217042108.185932-1-longman@redhat.com>
 <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
In-Reply-To: <CA+fCnZcaLBUUEEUNr8uZqW1dJ8fsHcOGCy3mJttfFDKq=A_9OQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fqOYkNTjyebKSbdEh-b7TLe2hFakLhkCvvdn9wv7zgw_1739814987
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/17/25 11:28 AM, Andrey Konovalov wrote:
> On Mon, Feb 17, 2025 at 5:21 AM Waiman Long <longman@redhat.com> wrote:
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
>> Commit e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> changes report_lock to a raw_spinlock_t to avoid a similar RT problem.
>> The print_address_description() function is called with report_lock
>> acquired and interrupt disabled.  However, the find_vm_area() function
>> still needs to acquire a spinlock_t which becomes a sleeping lock in
>> the RT kernel. IOW, we can't call find_vm_area() in a RT kernel and
>> changing report_lock to a raw_spinlock_t is not enough to completely
>> solve this RT kernel problem.
>>
>> Fix this bug report by skipping the find_vm_area() call in this case
>> and just print out the address as is.
>>
>> For !RT kernel, follow the example set in commit 0cce06ba859a
>> ("debugobjects,locking: Annotate debug_object_fill_pool() wait type
>> violation") and use DEFINE_WAIT_OVERRIDE_MAP() to avoid a spinlock_t
>> inside raw_spinlock_t warning.
>>
>> Fixes: e30a0361b851 ("kasan: make report_lock a raw spinlock")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   mm/kasan/report.c | 43 ++++++++++++++++++++++++++++++-------------
>>   1 file changed, 30 insertions(+), 13 deletions(-)
>>
>>   [v3] Rename helper to print_vmalloc_info_set_page.
>>
>> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
>> index 3fe77a360f1c..7c8c2e173aa4 100644
>> --- a/mm/kasan/report.c
>> +++ b/mm/kasan/report.c
>> @@ -370,6 +370,34 @@ static inline bool init_task_stack_addr(const void *addr)
>>                          sizeof(init_thread_union.stack));
>>   }
>>
>> +/*
>> + * RT kernel cannot call find_vm_area() in atomic context. For !RT kernel,
>> + * prevent spinlock_t inside raw_spinlock_t warning by raising wait-type
>> + * to WAIT_SLEEP.
> Quoting your response from the other thread:
>
>> Lockdep currently issues warnings for taking spinlock_t inside
>> raw_spinlock_t because it is not allowed in RT. Test coverage of RT
>> kernels is likely less than !RT kernel and so less bug of this kind will
>> be caught. By making !RT doing the same check, we increase coverage.
>> However, we do allow override in the !RT case, but it has to be done on
>> a case-by-case basis.
> Got it.
>
> So let's put this exactly this explanation in the comment, otherwise
> it's unclear why we need something special for the !RT case.

Sure. Will do that.


>> + */
>> +static inline void print_vmalloc_info_set_page(void *addr, struct page **ppage)
>> +{
>> +       if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +               static DEFINE_WAIT_OVERRIDE_MAP(vmalloc_map, LD_WAIT_SLEEP);
>> +               struct vm_struct *va;
>> +
>> +               lock_map_acquire_try(&vmalloc_map);
>> +               va = find_vm_area(addr);
>> +               if (va) {
>> +                       pr_err("The buggy address belongs to the virtual mapping at\n"
>> +                              " [%px, %px) created by:\n"
>> +                              " %pS\n",
>> +                              va->addr, va->addr + va->size, va->caller);
>> +                       pr_err("\n");
>> +
>> +                       *ppage = vmalloc_to_page(addr);
> Looking at the code again, I actually like the Andrey Ryabinin's
> suggestion from the v1 thread: add a separate function that contains
> an annotated call of find_vm_area(). And keep vmalloc_to_page()
> outside of it, just as done in the upstream version now.

I can make the change if it is what you want.

Cheers,
Longman

