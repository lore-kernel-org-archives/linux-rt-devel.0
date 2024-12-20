Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CA01B85C5
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734695291; cv=none; b=iMQ8wM2+Bx/9+XDEuFcwX9GXTuLf4xDPu9mNftg2mfH9Mq+VU8Lr2UquaWXAu9nrV2toLiE2LIJoHOC9NJQHsQ42+qO94LObeu0SJfvCnVM6+db+41h8BamWw4rljTQH3ZjcY7nRzWRbQrQASWXigqug1hvdkVhBdydeT7eFxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734695291; c=relaxed/simple;
	bh=QdEbAGmK7OdJCud0OaCJBnOFtqNvWyi1q8K11nl2O1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bERc48UKoNUUWd3zXoJ7SeM0BkIa2+IjMUsNwRlf3DO+Ae3EVY4OtrmFrswpn+CgDQ/9igKg+37mkF7pHvF5fef2quR4xEJcWJ8AEQhS9ZLwDy6lRiUdJUxfbIhXkoSzZX0df/6eLhQUkehyFQ2wyC5VQO8JWvoJG3EPiSK8XzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3380E1480;
	Fri, 20 Dec 2024 03:48:37 -0800 (PST)
Received: from [10.57.31.233] (unknown [10.57.31.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3E8043F58B;
	Fri, 20 Dec 2024 03:48:07 -0800 (PST)
Message-ID: <f0c15466-a27f-4cc2-90a1-476ec278d870@arm.com>
Date: Fri, 20 Dec 2024 11:48:06 +0000
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
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, james.clark@linaro.org,
 alexander.shishkin@linux.intel.com, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
 <CAJ9a7VhxG_8R6j5uRCzOhLpy4ZmzyVvyW0+ryCcd4w7wqpZ2ew@mail.gmail.com>
 <Z2VJIh2+Z40bZi1e@e129823.arm.com>
 <ac537889-dc0a-4d2e-870b-c5a33279633e@arm.com>
 <Z2VXc/R/nOLGz+Cg@e129823.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <Z2VXc/R/nOLGz+Cg@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/12/2024 11:39, Yeoreum Yun wrote:
> Hi Suzuki,
>> On 20/12/2024 10:38, Yeoreum Yun wrote:
>>> Hi Mike.
>>>
>>>> Notably missing is the same changes for the etm3x driver. The ETMv3.x
>>>> and PTM1.x are supported by this driver, and these trace source
>>>> variants are also supported in perf in the cs_etm.c code.
>>>
>>> But I wonder etmv3 needs to change. Because its spinlock is used only
>>> via sysfs enable/disable path.
>>> So, I think it doesn't need to change the lock type.
>>
>> ETM3 can be used in perf mode, similar to the ETM4x.
>>
>> So, you need to fix it as well.
> 
> Yes. But etmv3's etmdata->spinlock doesn't used in perf path
> its usage is only in sysfs interface path.
> That's why I think it could skip too.

Ok, which I think is a problem, since the sysfs mode could overwrite the 
"config" while perf is preparing the config from the event parsing.
And we would need it there. So, for the time being, we can accept this
series, pending other review comments and address this issue separately

Suzuki


> 
> Thanks.

