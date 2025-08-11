Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17D721504E
	for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921920; cv=none; b=u+P7kN2T62SrUw9bKm9qtCHQnZImXCEjvQraUi+PTKxJkSPB/0lbUhVieW2/GoBLAEI6RfTW0l8PIy2DZkuZ4kScVO1BAwK5P/3Nn05VRba2vhiKDgCd7nRLx2z3w5Tfie7AbhA8VgXgYjL1wrGAbXA3B+usv4dzFOWaD8JsrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921920; c=relaxed/simple;
	bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NGDFz8fprj30qgAnsBFczfyBydqNeBuW3KyFjqFQu6VWCVbq+Ed8bwLqoWAe7bB8vtqI9OLc5jAwZTp4Ai4Ok5PlZkGqK2mdF1tzv3MURLF+eOPp68/nCjMX6HCoHrBZAs+M79m5wdsD9Tkt/43UTMA54RbsrdvuQd4JtTscrNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NwA69rm0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NwA69rm0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754921917;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
	b=NwA69rm0ohJSiFW0GXDVo8wVCFi3YVvYmFD5BSvbValN9uyfNGzR7jckKLiYEjb0UuWifI
	/83I+VrULERYXJO6A8JauKgaEC1ZjMOweprqTf5LaeWm5oY4muRpHQbGAsMfBaUhDf7HSf
	ekh0fwRlAPtzSCR6DvOVTvvIXXmcNgk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-uAQnNwHaMYGTTjnKP-aLfA-1; Mon, 11 Aug 2025 10:18:36 -0400
X-MC-Unique: uAQnNwHaMYGTTjnKP-aLfA-1
X-Mimecast-MFC-AGG-ID: uAQnNwHaMYGTTjnKP-aLfA_1754921915
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45359bfe631so22822965e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 11 Aug 2025 07:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921914; x=1755526714;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLFqwIZV2uYlQb+YviFhY9gzykROzOF8Yh8va2JTzPo=;
        b=iekCZ/9Suk8ORf9GS4S0mJsjCYGHOkGzzF7jr/gYukZOMr1iR2qOLrSDhSODqm0IAG
         iB6lEXtuBrvhoTKKAAwFY1SiUmjWASoqoY4hnZAJNKx+FxtBkMQptW9csjfUzsuSfAx6
         X58iDKANA8Qdgx3njZekEhxmyWQMSMujyOKy4JBhaX7zXlJ1HnzmCDv++lhfOv2qmesb
         wjXrddFad8a9gH6kRJnJhPbuzcxRuXaGhBRC6Y832n6z/xYvHTQz2NVhPQCow+UVwiHR
         6uO1W9wWfPeS9GgB3w6pCPhu6ERqeGuQKvHMJ/OOe6fopTV8iagYSLIxhtMqhvVGXs23
         eRyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRcZ2LGPS1zgdZuWuSTCLwaD9T2etHZC83qTJlxkFxDM4WaMzkXyZqiJ7SixHHYNzDa94FOWmDzqPpRao9Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCMubTgOHmojHK3teHxkxYrGKWDEVxgHvTV9CzbDCJvveYTmXU
	oiuDtXBk5qkSKb3c6hPMubEKRgjNoIMGCfO/42wRmsXFn06Vf2GqgE1TXDyekct8xBgYzErrsBE
	MyvpKNnz0uYnz2onQ9NkJdD+6+AEEDx+EFefv13Xjhe4gXH5BGXUYnL6H5UYf9HaQLVRhodnUKk
	JA4S8aXT8xNq0lsAPUofIcGkmWVZXEgs0HKFJfl2WNV0TzLmUXLCz5
X-Gm-Gg: ASbGncsDJAiJry9hlNTONUi4V6g+jQCtVhz1ErXVlMB4JABZXbDmbSlIGSwKkO1tW/s
	cqvIxfMLxKuBY5UyDTSIIaogGn7EUTuECDqt+dkGvsSdH1dn4OcXBH1OJMss3S4jV145CqTP+7H
	Vl2F/22BMkpWvpIZdAC4vecM8iWtaJURP34aMqMuZmYdLZDayuVrVztlOiL/GY+35L5vSk4DQbF
	/Ks+ZWB3jwnHxsRUW0602d0TYMImATCODA9EV71q5kSZv6zEn1Zg5ss+OE5ZJy39/ZvpQdj9Rpe
	3syIMYtivxPR25v7ZPN/a0ypyOcNDqGxrMDht2V5ravkNTaotEBzZ9YH1DrkVVkToTCljJK94f4
	90XlpywmDp3F1vSBHOAy71gQR
X-Received: by 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr84932825e9.30.1754921913978;
        Mon, 11 Aug 2025 07:18:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEK7xe2jj9RDZcj2jypfYQ8QNxrGhvt+A2f3vSrNMfxeIGmWZ42MdaPGKXHKFv5KHpImfzFjg==
X-Received: by 2002:a05:600c:15d1:b0:459:e025:8c5b with SMTP id 5b1f17b1804b1-459f60d2211mr84932405e9.30.1754921913488;
        Mon, 11 Aug 2025 07:18:33 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459ebede65asm208975165e9.8.2025.08.11.07.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:18:32 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Xin Zhao
 <jackzxcui1989@163.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, will@kernel.org, boqun.feng@gmail.com,
 longman@redhat.com, clrkwllms@kernel.org, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] sched/cgroup: Lock optimize for cgroup cpu throttle
In-Reply-To: <20250811083622.C29-WNtR@linutronix.de>
References: <20250811070838.416176-1-jackzxcui1989@163.com>
 <20250811083622.C29-WNtR@linutronix.de>
Date: Mon, 11 Aug 2025 16:18:31 +0200
Message-ID: <xhsmho6smhrgo.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N69rL-Y960ZsZOmdFkrm12Nu5S9tsuquzzASjYmTCbs_1754921915
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

On 11/08/25 10:36, Sebastian Andrzej Siewior wrote:
> On 2025-08-11 15:08:38 [+0800], Xin Zhao wrote:
>> After enabling PREEMPT_RT, ordinary spinlocks can also be subject to cgroup
>> limits during the lock-holding period. This can lead to seemingly unrelated
>> threads experiencing timing dependencies due to underlying logic, such as
>> memory allocation, resulting in delayed wake-up behaviors that are difficult
>> to understand when analyzing traces captured by tools like Perfetto.
>> Due to the prevalence of this performance issue when using cgroup CPU
>> throttling with PREEMPT_RT, the CGROUP_LOCK_OPTIMIZE configuration will be
>> enabled by default when both PREEMPT_RT and CFS_BANDWIDTH are activated.
>> This configuration option temporarily increases the priority of tasks to
>> SCHED_RR 1 if they hold a lock (excluding raw spinlocks, RCU, and seqlock)
>> and are limited by cgroup, provided they are SCHED_NORMAL. Once the lock is
>> released, the priority will be restored.
>> This patch is a derivative of the priority inheritance patch. While priority
>> inheritance can cover scenarios involving spinlocks and mutexes, it cannot
>> address the timing dependency issues between two SCHED_NORMAL tasks caused
>> by underlying locks. Additionally, the lazy_preempt feature does not cover
>> scenarios where a real-time task, such as a ktimer, interrupts a lock-holding
>> SCHED_NORMAL task, which is then throttled by cgroup cpu.
>> This patch not only addresses the issue of cgroup limits affecting spinlocks
>> under PREEMPT_RT but also resolves issues related to holding mutex or
>> semaphore locks, as well as other core rt_mutex locks under PREEMPT_RT.
>> The following stack trace illustrates the delayed wake-up behavior caused by
>> two seemingly unrelated threads due to underlying logic:
>
> urgh.
>
> What about using task_work_add() and throttling the task on its way to
> userland? The callback will be invoked without any locks held.
>

Yeah, please have a look at:
https://lore.kernel.org/lkml/20250715071658.267-1-ziqianlu@bytedance.com/

> Sebastian

