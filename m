Received: from mail-pz2-f0.google.com (mail-pz2-f0.google.com [74.125.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B877F1D6DB5
	for <linux-rt-devel@lists.linux.dev>; Wed,  8 Jul 2026 01:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.0
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474282; cv=none; b=IL10rmL0TSw5/8O1rSYlWqu5VNyMcYQWRqXIPUZJUqb3pYspg3P4b3WqbLCMZtizDgIRb3uvRXk0wgW6uqo1ox1zDJBiMdyuIoD80ktxWGk0IN07Gnb+7DHE5vGV2iEVpJJdDJB6JhRAILbKmyDmGFo54Uh2Mdiaha0jBG6mrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474282; c=relaxed/simple;
	bh=OVmXd4rCBHziySVsuXof+n5zHjriBavZp5Q1amysqzs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZuZ5USYk1O4+zkKuxf9HdyuHQt5SE+swX8EjXPoYYSmfZ0NUdytGo1W1TGlIe4clcMQ5h7h7/YmiktRgU5kRjKtzCvMcICXzbCBSY15eAC55NCi3/n2OycWR7KjaewCBKuFr7wBO3GKK9lJSi0g48y/WzhcpTWiQdO8IJR+mG9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdY0f3f4; arc=none smtp.client-ip=74.125.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdY0f3f4"
Received: by mail-pz2-f0.google.com with SMTP id 41be03b00d2f7-ca24d39d8a4so53232a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 18:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783474280; x=1784079080; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D/LQLPuILxjB411/fYFouWHdkKkRbW9iZLAYWIeHak0=;
        b=qdY0f3f4ZYuQewmF+BgFYpllvuf1HnOPBN+/Zrq6X9dId5VoUPGR3R5DXOK9ZVC7uf
         cfV5/U0+i2B7iVC4AdMtgpF5hoqwGu0YhfAqdlA2TPtgB4hpZpLO2yx+XLy7NE9z0nsD
         KadV4XHOBnr0Eo1OxeJUKhrvGpowSy3gP7BsvTNuNwkAE27zoXVfbnVS3n+OR68mZpI0
         RDoMmA21AoLGUmu4OJbKZk4MQ2JeHZxtVAuzSGDrPhxwAeZf7e4cSL3u+q74NsfYu0OT
         bQyhhbS4TwNILx4TCjPz/9EEcet4pbmtYoTjc9orGiNNr5+B5VvhoX9iX0ZLvxTimKwA
         1teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783474280; x=1784079080;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D/LQLPuILxjB411/fYFouWHdkKkRbW9iZLAYWIeHak0=;
        b=hYs6OLgDuj5uDVA81zOfRQNesFUzBIsA1ZzTsQvBU/D/p4aRjEfsM2AjIGHF1JzNmQ
         V8lE5UGUOgtCotYxlO1Za3fLLLYM6lBfeeSVIKjW2rZbB126n6vZhtSWe1i3jq0rTzbC
         ynHAInw5OuLs4rifVvTxCJBhwmwm4RtxCqK4x0i3x54Df4DH36Ep54ynHu3xs+OIr/cy
         9QX3OopjX7sZLjpzYAPDHM77ZWobm/C+BWCClV755tOiCk+bJ46Ul2wlqRYDDWn4CS7/
         zdEl8EaYQUROW5USt5sRvYc6aGZPem+WqnqQRb0hkXiX/8hR+1T5C64IIrQxHnuNfOsv
         gJ6A==
X-Forwarded-Encrypted: i=1; AHgh+Rou937/AYZnyw/zoIWQScOXOnk6QwoWWS20tLSffJQ7TaoXJkDosUSFmWJACXQB6f+oJlGt210+P//CmSruOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxe9ApAiiaE6Vl9KjspNJDCtl2V8E0tXSIXkYlF0U1+gF7nayRt
	tJSLbXKoXL5F8pDhwtPLN/17EsjogIMQj8wpCFHiUVKjeVz4swkeDe9p
X-Gm-Gg: AfdE7cla7giI6nqM3yl+83YmgALllOcap+JET/h+NkVCB2uPW5y8/dnFTj38ah739xS
	dCXwvfoR1KJGQ+LTQAH0BGd/XmYBFIIM465JihSgfcKtC+PHpsAPwOlnPSSe/6LYM/QAVxmeWTG
	LyAg76r0o54xq0UuMvfys7vlsfH/kulXCIEoUBiB7+49toqhyi64At6cBcSnzYSz+nQn0orpNIS
	Jc51DTRBJm1m0b3b94Z4gCENu/NO9KX4H9/+UCISIyfye0yo3XV6PYW0uSZ7ZdyFj3tK9wNTn90
	JzAFW93BTWtvVESz9rtGo6PL+r8xaZ6dOhrMw0qp7X6pQEwt/M7XpBMe0ZAG5xveF3XG2iNAEOz
	DSafyBLW8W1EhQXIYwaceZN34YPjuRRfvCT3Q6I3Sn5uAElcAzBIJxztXsisSZurt3WrfPcy6g7
	ITBaP2gORJa0MHZcPyl6eE
X-Received: by 2002:a05:6a21:62c6:b0:398:837a:7af0 with SMTP id adf61e73a8af0-3c0bd04207cmr152449637.30.1783474280029;
        Tue, 07 Jul 2026 18:31:20 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5af7d58f3sm1656435a12.1.2026.07.07.18.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 18:31:19 -0700 (PDT)
Message-ID: <e4761ca0-21d2-41d5-8d0f-ec14d0a5d3b9@gmail.com>
Date: Wed, 8 Jul 2026 09:31:09 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
From: Wandun <chenwandun1@gmail.com>
To: Alexander Krabler <Alexander.Krabler@kuka.com>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "surenb@google.com" <surenb@google.com>, "mhocko@suse.com"
 <mhocko@suse.com>, "jackmanb@google.com" <jackmanb@google.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>, "ziy@nvidia.com"
 <ziy@nvidia.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mhiramat@kernel.org" <mhiramat@kernel.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "david@kernel.org" <david@kernel.org>, "ljs@kernel.org" <ljs@kernel.org>,
 "liam@infradead.org" <liam@infradead.org>, "rppt@kernel.org"
 <rppt@kernel.org>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
 "clrkwllms@kernel.org" <clrkwllms@kernel.org>,
 Hugh Dickins <hughd@google.com>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <969cb14b-5b8b-48e6-add6-4dd13101dd89@kernel.org>
 <040788a9-e0d5-478e-bb48-3d22b8b41020@gmail.com>
 <c8793c0f-7156-4cb7-9e6e-7909397e2fff@kernel.org>
 <ca1115c0-1509-453a-8235-08e381a3da6f@gmail.com>
 <PR3PR01MB6666C11E08516555C153D4FD82EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <a96b0b24-c405-43c4-96ef-605bacd17cad@gmail.com>
 <PR3PR01MB6666EC8D53E75F742B37270282EB2@PR3PR01MB6666.eurprd01.prod.exchangelabs.com>
 <05d7369e-341c-49f4-ae13-df3d0ad930d7@gmail.com>
Content-Language: en-US
In-Reply-To: <05d7369e-341c-49f4-ae13-df3d0ad930d7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/29/26 17:07, Wandun wrote:
> 
> 
> On 6/26/26 21:42, Alexander Krabler wrote:
>> On 6/26/26 11:38, Wandun wrote:
>>> On 6/26/26 16:45, Alexander Krabler wrote:
>>>> However, we were not able to reproduce the actual race
>>>> (mlockall() process waiting on a migration PTE),
>>>> not in the past, not now. Might be hard to trigger that race.
>>>
>>> Not hard to trigger that case, I added a debug message, such as below,
>>> lots of messages occur in a few second.
>>>
>>> diff --cc mm/memory.c
>>> index ff338c2abe92,ff338c2abe92..6552b3b14f78
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@@ -4768,6 -4768,6 +4768,8 @@@ vm_fault_t do_swap_page(struct vm_faul
>>>                 if (softleaf_is_migration(entry)) {
>>>                         migration_entry_wait(vma->vm_mm, vmf->pmd,
>>>                                              vmf->address);
>>> +                       if (!strcmp(current->comm, "repro"))
>>> +                               pr_err("============== hit ================\n");
>>>                 } else if (softleaf_is_device_exclusive(entry)) {
>>>                         vmf->page = softleaf_to_page(entry);
>>>                         ret = remove_device_exclusive_entry(vmf);
>>
>> I have a kprobe on migration_entry_wait set and logged into a ftrace buffer
>> (including kernel stacktrace).
>> Yes, this function is hit, but only inside the mmap-syscall, which is okay,
>> memory allocation is not realtime-safe.
>>
>>            repro-2090    [002] d....   811.129549: frt_migration_entry_wait: (migration_entry_wait+0x0/0x100)
>>            repro-2090    [002] d....   811.129553: <stack trace>
>>  => migration_entry_wait
>>  => __handle_mm_fault
>>  => handle_mm_fault
>>  => __get_user_pages
>>  => populate_vma_page_range
>>  => __mm_populate
>>  => vm_mmap_pgoff
>>  => ksys_mmap_pgoff
>>  => __arm64_sys_mmap
>>  => el0_svc_common.constprop.0
>>  => do_el0_svc
>>  => el0_svc
>>  => el0t_64_sync_handler
>>  => el0t_64_sync
>>
>> The original race was an instruction abort interrupt out of nothing due
>> to the migration PTE set by kcompactd.
>> And these kind of races I see quite often on non mlockall()-processes,
>> but can't reproduce on memory locked processes.
>>
>> Example:
>>           podman-832     [000] d....   812.447820: frt_migration_entry_wait: (migration_entry_wait+0x0/0x100)
>>           podman-832     [000] d....   812.447823: <stack trace>
>>  => migration_entry_wait
>>  => __handle_mm_fault
>>  => handle_mm_fault
>>  => do_page_fault
>>  => do_translation_fault
>>  => do_mem_abort
>>  => el0_da
>>  => el0t_64_sync_handler
>>  => el0t_64_sync
> 
> Hi, Alexander
> 
> From the perspective of the root cause, there is no fundamental difference
> between these two call stacks. I modified the reproduction program, and it
> can still reproduce the situation of the second call stack
> (although it doesn't occur as frequently). The complete reproduction program
> is as follows:
> 
> 
> #define _GNU_SOURCE
> #include <fcntl.h>
> #include <pthread.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <sys/sysinfo.h>
> #include <unistd.h>
> 
> #define PAGE_SIZE       4096
> #define NR_PAGES        10000
> 
> static void *worker_fn(void *arg)
> {
> 	int fd = (long)arg;
> 	size_t len = NR_PAGES * PAGE_SIZE;
> 
> 	while (1) {
> 		if (ftruncate(fd, 0) < 0) {}
> 		if (ftruncate(fd, len) < 0) {}
> 
> 		char *p = mmap(NULL, len, PROT_READ | PROT_WRITE,
> 			       MAP_SHARED, fd, 0);
> 		if (p == MAP_FAILED)
> 			continue;
> 
> 		mlockall(MCL_ONFAULT |  MCL_FUTURE);
> 
> 		for (int i = 0; i < NR_PAGES; i++) {
> 			for (int j = 0; j < PAGE_SIZE; j++) {
> 				p[i * PAGE_SIZE + j] = 1;
> 			}
> 		}
> 
> 		usleep(200);
> 		munmap(p, len);
> 	}
> 	return NULL;
> }
> 
> static void *compact_fn(void *arg)
> {
> 	(void)arg;
> 	int fd = open("/proc/sys/vm/compact_memory", O_WRONLY);
> 	if (fd < 0)
> 		return NULL;
> 
> 	while (1) {
> 		if (write(fd, "1", 1) < 0) {}
> 		usleep(5000);
> 	}
> }
> 
> int main(void)
> {
> 	int nproc = sysconf(_SC_NPROCESSORS_ONLN);
> 	if (nproc < 1)
> 		nproc = 1;
> 
> 	int *fds = calloc((size_t)nproc, sizeof(int));
> 	if (!fds)
> 		return 1;
> 
> 	size_t len = NR_PAGES * PAGE_SIZE;
> 	for (int i = 0; i < nproc; i++) {
> 		char path[64];
> 		snprintf(path, sizeof(path), "./repro_%d.dat", i);
> 		unlink(path);
> 		fds[i] = open(path, O_RDWR | O_CREAT, 0600);
> 		if (fds[i] < 0)
> 			return 1;
> 		if (ftruncate(fds[i], len) < 0)
> 			return 1;
> 	}
> 
> 	printf("repro: %d workers, %d pages, Ctrl-C to stop\n",
> 	       nproc, NR_PAGES);
> 
> 	pthread_t compact;
> 	pthread_create(&compact, NULL, compact_fn, NULL);
> 
> 	pthread_t *threads = calloc((size_t)nproc, sizeof(pthread_t));
> 	for (int i = 0; i < nproc; i++)
> 		pthread_create(&threads[i], NULL, worker_fn, (void *)(long)fds[i]);
> 
> 	pthread_join(compact, NULL);
> 	return 0;
> }

I found there are false positives in this reproducer.
I modified the program a little,  the diff is as follows,
the problem can still be reproduced


diff --git a/repro.c b/repro.c
index b1b34d5..59cb417 100644
--- a/repro.c
+++ b/repro.c
@@ -15,6 +15,7 @@ static void *worker_fn(void *arg)
        int fd = (long)arg;
        size_t len = NR_PAGES * PAGE_SIZE;

+       mlockall(MCL_ONFAULT |  MCL_FUTURE | MCL_CURRENT);
        while (1) {
                if (ftruncate(fd, 0) < 0) {}
                if (ftruncate(fd, len) < 0) {}
@@ -24,8 +25,6 @@ static void *worker_fn(void *arg)
                if (p == MAP_FAILED)
                        continue;

-               mlockall(MCL_ONFAULT |  MCL_FUTURE);
-
                for (int i = 0; i < NR_PAGES; i++) {
                        for (int j = 0; j < PAGE_SIZE; j++) {
                                p[i * PAGE_SIZE + j] = 1;


> 
> 
> 
> 
>>
>> Thanks,
>> Alexander
>>
>> --
>>
>> KUKA Deutschland GmbH   Board of Directors: Michael Jürgens (Chairman), Johan Naten, Hui Zhang   Registered Office: Augsburg HRB 14914
>>
>> This e-mail may contain confidential and/or privileged information. If you are not the intended recipient (or have received this e-mail in error) please notify the sender immediately and destroy this e-mail. Any unauthorized copying, disclosure or distribution of contents of this e-mail is strictly forbidden.
>>
>> Please consider the environment before printing this e-mail.
> 

