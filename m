Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591221;
	b=VVXinHrU59g9CIyR+302t+dUqQb2ieO52YSgLxMg1rclefTTDrm8hnJ7TckNeugnxUlx
	 76v5iJvAgnXGXSdkL0PCefQ9qfPo/qYucun1v70eZzreUL3y22GblVAyGymE4bVrpsVPt
	 mSJPk5WrhOKLe+VThy8Gw8UemFXvJjIew7NZOW4A8nfXe5/qvJo5iVMI2tSDMqpHcx2SB
	 R9XdtGrFid9hx1AmtlRNnEOWIamfY1y/ZG9qqCZ+beoNNRdNh2wP59Ic2nS1oZuqhbrQn
	 rFc/9U3fVpBNHyfyGlDioqjH4LT/9FkV7c5EXmyhNR7I0MCXVK3LnB1VyJ/5a6Ihf9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591221;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=b8xUdlTrVJr8iWSKlRDFOvStv40KWS4yRp1fHWJ2LrY=;
	b=uBWedh7rPrvJHqNFM1DlaJJpiHzb/QKww1WuneH224DCJsCMTmC5a4KrpW+HHkXvYg7X
	 5AApDE8y1dKsq4tcR9CZRjODUwrHdOpOo5IEykjlLJx7LtIviAgMrlWtNs5R9nQXr+q6z
	 vpCayoJK2BLfiMjsehsuNkvTGVESb+aGxqPK+/+XROQkuPWj2rom6jN9HJAASidjZs391
	 85i4OJZgCqCBAOO7eLN4QGE5T6pKypkAgLX7QI3SmWowJQ72kW2esSNs6jfiC15I8Nka3
	 MJFvvjbfOKtp8RGnNun63QTeIPjPCciYPLxGtR4uJdBuxyk7JiAavDrJX1Fsk0/Wc0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFVKWxIk;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721E8607587F
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 17:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 721E8607587F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CFVKWxIk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794591219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8xUdlTrVJr8iWSKlRDFOvStv40KWS4yRp1fHWJ2LrY=;
	b=CFVKWxIk/AcQqCcM2rQZaoAqInwIVOmvFp7KtNF7zWKCu+M08eQv9yXA2vpke69gOouqhD
	d26FW9Vv5gRDG+lLl+oGAiJfKzxrKmFawJ3XXATd9uUgyPqQuPAifq/kFGF+82Hre9K4mu
	fT8JF2nLki+hEEzOkU9LxJSwd76WC3o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-rMtnh44bMoyNRQ_zKEvztQ-1; Fri,
 13 Nov 2026 12:33:32 -0500
X-MC-Unique: rMtnh44bMoyNRQ_zKEvztQ-1
X-Mimecast-MFC-AGG-ID: rMtnh44bMoyNRQ_zKEvztQ_1794591209
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FCCD1800349;
	Fri, 13 Nov 2026 17:33:28 +0000 (UTC)
Received: from [100.91.18.181] (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DCCCE1800559;
	Fri, 13 Nov 2026 17:33:22 +0000 (UTC)
Message-ID: <638e3138-1dfe-42a0-97bf-2acb32970fa3@redhat.com>
Date: Fri, 13 Nov 2026 12:33:21 -0500
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only
 where room was made
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: juri.lelli@redhat.com, peterz@infradead.org, mingo@redhat.com,
 vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, tglx@kernel.org,
 will@kernel.org, boqun@kernel.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, kprateek.nayak@amd.com, luca.abeni@santannapisa.it,
 mathieu.poirier@linaro.org, ridong.chen@linux.dev, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, shuah@kernel.org,
 bigeasy@linutronix.de, clrkwllms@kernel.org, parri.andrea@gmail.com,
 m.szyprowski@samsung.com, kayracizmeci@gmail.com, weihengqiuu@gmail.com,
 cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
 <bcb60245-abfb-4e3a-aa4e-f134ed310381@redhat.com>
 <20261113135110.160083-1-mathieu.desnoyers@efficios.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20261113135110.160083-1-mathieu.desnoyers@efficios.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: USr8g11bgWizf6R89eQE_4dX25G8hcxkOZjYA9me3yg_1794591209
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/13/26 8:51 AM, Mathieu Desnoyers wrote:
> Hi Waiman,
>
> On 2026-11-12 23:37, Waiman Long wrote:
>> For cpuset v2, it is not possible for a cpuset to span two root domains.
>> I believe it is not possible for v1 too, though I am not 100% sure.
>> Please let me know if you are aware of a way to do that.
> It happens with isolcpus="domain". The CPUs it isolates stay in the
> effective CPUs of the top cpuset, and of any cpuset that is not a
> partition root. They are in the default root domain. The other CPUs
> are in another root domain.
>
> The message should have named isolcpus. The planned next version does.
Right, top_cpuset is the exception here. Boot isolated CPUs are not 
allowed in a root partition. They are only allowed in isolated 
partitions. So root partition other than the top one cannot span more 
than one root domain.
>
> This is on tip sched/urgent (v7.4-rc1 based), in a 5-CPU guest booted
> with isolcpus=domain,1,2. A is a plain cgroup v2 cpuset:
>
>    # cat /sys/devices/system/cpu/isolated
>    1-2
>    # echo 0-4 > A/cpuset.cpus
>    # cat A/cpuset.cpus.effective
>    0-4
>    # cat A/cpuset.cpus.partition
>    member
>
> Two tasks in A call sched_setattr(SCHED_DEADLINE). Task 95 is pinned to
> CPUs 0,3,4 and asks for 10%. Task 98 is pinned to CPUs 1,2 and asks for
> 20%. Both are admitted. /sys/kernel/debug/sched/debug gives total_bw of
> the root domain of each CPU. "Before" is the fair servers alone:
>
>    CPU     before    with the two tasks
>    0,3,4   157284    262141   (+10%)
>    1,2     104856    314571   (+20%)
>
> So the two tasks are in the same cpuset and are counted in two root
> domains. Then task 95 is given CPU 1 alone:
>
>    # taskset -p 2 95
>    taskset: can't set pid 95's affinity: Device or resource busy
>    # echo -1 > /proc/sys/kernel/sched_rt_runtime_us
>    # taskset -p 2 95
>    pid 95's new affinity mask: 2
>
> After that, total_bw is 157284 for CPUs 0,3,4 and still 314571 for
> CPUs 1,2. The 10% of task 95 is counted nowhere. That is the case the
> patch fixes.
>
> I did not test cgroup v1.
>
> The planned next version has a new cpuset patch for the same
> configuration. A deadline task in such a cpuset can also change root
> domain when its cpuset loses CPUs. The patch refuses that:
> - a write to cpuset.cpus fails with EBUSY if it leaves a deadline task
>    no CPU in the root domain that counts it;
> - cpuset makes a partition root invalid if it would do the same.

We already have pending cpuset patch that will disallow taking the last 
housekeeping CPU from the top_cpuset partition.  The partition will be 
disabled in that patch if users attempt to do so. So it is effectively 
changing the root domain to that of the parent cpuset.

As said above, a partition below the top_cpuset cannot span more than 
one root domain. Are you referring to the case that shrinking the cpuset 
CPU count to reduce the total DL bandwidth will fail with EBUSY when it 
is less than what the existing DL tasks require?

Thanks,
Longman
>
> My reply to Juri on patch 20 describes it with two related patches:
> https://lore.kernel.org/all/e21aaf40-b929-444c-b707-3200e21d7301@efficios.com/
>
> I would like your opinion on these two refusals before I post the
> patch.
>
> Thanks,
>
> Mathieu

