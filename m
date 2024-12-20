Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250918BC3F
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734694541; cv=none; b=pmYdzErOVvTyeO0saihN8i+xe2I88jm/+QxIsr4Rnwg4HubLprVVVNSYErmvY7ryRxykopffOqMFgU98jquehyMV1zRKoCJbW1Al9yF9NjMjqfRZPwsY6I1UmOfe4C8ulKS2xt2agd+/iquiF6MohidLoC3F2eDebXRvDO5pJiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734694541; c=relaxed/simple;
	bh=pXH4Uj9AIgrz03SDGEasTrHvIXTg3J4ym6+J4vqXos8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kQgNr5FugBe5Jgu22s2kcOvImNUg6pHM5r9/gaO39d4eWDgmxwG0i3+GDnnuLFrn8zf4D1IUQIKybdUzt/4NhSiGJ+EGCrSpPpPfj38uQmM6vjLzJNMWjCzAzjSAjmh42mk+4X7lD8qStHKqzirt75oijw3voCoQ6qG1w2ndz6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84D911480;
	Fri, 20 Dec 2024 03:36:07 -0800 (PST)
Received: from [10.57.31.233] (unknown [10.57.31.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90AB83F58B;
	Fri, 20 Dec 2024 03:35:37 -0800 (PST)
Message-ID: <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
Date: Fri, 20 Dec 2024 11:35:36 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] coresight: change some driver' spinlock type to
 raw_spinlock_t
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, Mike Leach <mike.leach@linaro.org>
Cc: james.clark@linaro.org, alexander.shishkin@linux.intel.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
 <Z2VJIh2+Z40bZi1e@e129823.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Z2VJIh2+Z40bZi1e@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 10:38, Yeoreum Yun wrote:
> Hi Mike.
> 
>> Notably missing is the same changes for the etm3x driver. The ETMv3.x
>> and PTM1.x are supported by this driver, and these trace source
>> variants are also supported in perf in the cs_etm.c code.
> 
> But I wonder etmv3 needs to change. Because its spinlock is used only
> via sysfs enable/disable path.
> So, I think it doesn't need to change the lock type.

ETM3 can be used in perf mode, similar to the ETM4x.

So, you need to fix it as well.


> 
>> STM is also missing, though this is not directly enabled via perf -
>> but could perhaps run concurrently as it can be a target output for
>> ftrace.
> 
> Actually, I couldn't find out the path where
> the STM's lock could be grabbed under other raw_spin_lock (including csdev)
> If you don't mind would you let me the code path please?

STM can't be used in perf mode, and as such you may skip it.

Suzuki


> 
> Thanks
>> --
>> Mike Leach
>> Principal Engineer, ARM Ltd.
>> Manchester Design Centre. UK

