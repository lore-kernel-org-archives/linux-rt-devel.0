Received: from smtpcmd11117.aruba.it (smtpcmd11117.aruba.it [62.149.156.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157403D813E
	for <linux-rt-devel@lists.linux.dev>; Thu, 11 Jun 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176345; cv=none; b=sV4tCsleAOYXMa6jfz7S9TMvJbOPc4cKDzGhoEZfG72XJJAaTE4EeTlDaSH0jqL3WvkChiBxd8gOpvqBmP2AAdkAtXXB9nuwMdHvMUsxgvXE1okiLxDpmYeMhgDvayU1rB12kxtBr1u3e4Q3AvLLQXDg9/1Bjb9cBos52o2yDGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176345; c=relaxed/simple;
	bh=f8bg91u8tYipWeDu0pSu2C2PneIg2ADefqXObCtqA8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI7xLwvppHeiCKZP4bzTJjaCKcq7qw5nPJlUfBz0oS6/XnTBih+pOeT3YrX5UDwuKHiOm24yXYGJZZ7PTj7FR+qtHcyKGEOgKvRAxxjzLPXcIAngO20Sfmr9TTpRBK7stqVCQt/YlF1Fhgad2uThjAa0tFnu5y8I+oicC+SZPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=PQuJvcdJ; arc=none smtp.client-ip=62.149.156.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="PQuJvcdJ"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id XdHcwF8a9iOfFXdHcwRYHR; Thu, 11 Jun 2026 13:09:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1781176152; bh=f8bg91u8tYipWeDu0pSu2C2PneIg2ADefqXObCtqA8I=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=PQuJvcdJxpSxzkyTdjn8u614nwomAaXdIgwvkQMMVeLW2g5vEAwy2SyzQyg8d/ZWo
	 TYA8EUlVSQVck5KRW/5M6K2YCW9QV3Uhr6sJMcV+jLLZhIO988TMnG3sQi1t//tSqn
	 FGO42RT90OkwcJUMG9VipV1HvN9EzkDFFa1GYMQ8f3K3VgI7nPaxz2egqdQc9Z1ulu
	 Ej5QkzMHKEZphvgfkbCkR/aMByj/C3Y8yeDiEJ5F+XsLE45/r0M2j+pUviQIZAk+qv
	 cJaHV0zXUBQC+N0ThnGJAUOCw8MoUk3rjifh+eBTOhOSo/mv02YHMmqAyWne5wxXjQ
	 Q5mC9klkzNZpQ==
Message-ID: <b35618b7-5ca3-462c-a656-ae46ae18002d@enneenne.com>
Date: Thu, 11 Jun 2026 13:09:11 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: Don't try to wait for negative timeouts in PPS_FETCH
Content-Language: en-US
To: Calvin Owens <calvin@wbinvd.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <b5241c09ac0dfb82ee076d06367ac6319471c773.1780071212.git.calvin@wbinvd.org>
 <20ed84f3-14d9-4936-b6d1-915ab605b7fa@enneenne.com>
 <ahr6IHpbRRlpTMbp@mozart.vkv.me>
 <ee1b67f4-1627-4999-be4e-e21ac2dff9dd@enneenne.com>
 <aimHUam6s3j147-A@mozart.vkv.me>
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <aimHUam6s3j147-A@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFNp2iv3omG4kk183HmrUi/6kHbSY8eK9WGdzRe2g7eckkGaoZT2n3i8sYSgCz+FOIq4l0vMNGkRnl9GHfgFKBF+ag4t+uYfjTcQa6UGb1ksyGJDGWU8
 ILjY2qeKa5QY4VUa/Ud1qVkuqZm54tO9ATsCCVYNeDwkCDpz7kRAwS+LSko7TG4JILPbFVRzFWlh36n2bpuNmA4PyNzZ4zBn8VPQ36lm0qU7aooUGnEUa3s3
 P/iDOyI24OFP42PNsoRsMi2N9TNY7xQ8vMgmhuQPs7/jpK+9doJ0HvWy99ksx/HBoN4vqsjlyUZoOIhPsJ0Ql4lMiLErJ4MPlJmLUOKWs57CJnIW2TAadduc
 q3bjTZRMyscqCNKTCLCYXQXgnYKV6TddWnfLzIcKVR6wfDeCKc9FkI1muCqcFRVuQ1Ia0LGR

On 10/06/2026 17:48, Calvin Owens wrote:
> On Monday 06/01 at 09:04 +0200, Rodolfo Giometti wrote:
>> On 30/05/2026 16:54, Calvin Owens wrote:
>>> On Saturday 05/30 at 11:50 +0200, Rodolfo Giometti wrote:
>>>> On 29/05/2026 18:21, Calvin Owens wrote:
>>>>> If userspace passes a negative timeout to PPS_FETCH, it triggers a
>>>>> kernel splat from schedule_timeout():
>>>>>
>>>>>        schedule_timeout: wrong timeout value fffffffffff0bfb4
>>>>>        CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
>>>>>        Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
>>>>>        Call Trace:
>>>>>         <TASK>
>>>>>         dump_stack_lvl+0x4b/0x70
>>>>>         schedule_timeout+0xb7/0xe0
>>>>>         pps_cdev_pps_fetch.isra.0+0x93/0x150
>>>>>         pps_cdev_ioctl+0x70/0x310
>>>>>         __x64_sys_ioctl+0x7b/0xc0
>>>>>         do_syscall_64+0xb6/0xfc0
>>>>>         entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>>
>>>>> Sashiko imagines this to be some sort of security problem, which is
>>>>> obviously really silly. But I think it is still worth fixing, so buggy
>>>>> userspace code can't trigger the splat.
>>>>>
>>>>> Silence the splat by skipping the wait if the ticks count is negative.
>>>>> The current behavior is to return -ETIMEDOUT in that case, so keep that
>>>>> return value in case any userspace code might rely on it.
>>>>>
>>>>> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
>>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>>> Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
>>>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>>
>>> Hi Rodolfo,
>>>
>>> Thanks for taking a look at this and the others.
>>>
>>>>> ---
>>>>>     drivers/pps/pps.c | 6 ++++--
>>>>>     1 file changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>>>> index de1122bb69ea..6755901fbdae 100644
>>>>> --- a/drivers/pps/pps.c
>>>>> +++ b/drivers/pps/pps.c
>>>>> @@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
>>>>>     	if (fdata->timeout.flags & PPS_TIME_INVALID)
>>>>>     		err = wait_event_interruptible(pps->queue,
>>>>>     				ev != pps->last_ev);
>>>>>     	else {
>>>>> -		unsigned long ticks;
>>>>> +		long ticks;
>>>>>     		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
>>>>>     				(long long) fdata->timeout.sec,
>>>>>     				fdata->timeout.nsec);
>>>>>     		ticks = fdata->timeout.sec * HZ;
>>>>>     		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>>>>> -		if (ticks != 0) {
>>>>> +		if (ticks < 0) {
>>>>> +			return -ETIMEDOUT;
>>>>> +		} else if (ticks > 0) {
>>>>>     			err = wait_event_interruptible_timeout(
>>>>>     					pps->queue,
>>>>>     					ev != pps->last_ev,
>>>>>     					ticks);
>>>>
>>>> Should the problem originate from user-space data, I deem it more
>>>> appropriate to verify them directly, rather than relying on computed data.
>>>>
>>>> 	unsigned long ticks;
>>>>
>>>> 	if (fdata->timeout.sec < 0 || fdata->timeout.nsec < 0)
>>>> 		return -ETIMEDOUT;
>>>
>>> I agree your way is nicer to read.
>>
>> We can also do as follow:
>>
>> 	/* Canonical validation of nanoseconds */
>> 	if (fdata->timeout.nsec < 0 || fdata->timeout.nsec >= NSEC_PER_SEC)
>> 		return -EINVAL;
>>
>> 	/* Preserve historical API behavior for negative seconds */
>> 	if (fdata->timeout.sec < 0)
>> 		return -ETIMEDOUT;
> 
> Thinking about this a little more... code in the kernel generally doesn't
> try to enforce tv_nsec < NSEC_PER_SEC from userspace today.
> 
> I think nobody cares: let's just not worry about tv_nsec unless you
> really think a real user will care.
> 
> If it's worth fixing, it ought to be done more systematically throughout
> the kernel, I feel like adding the check in random places makes the
> situation more confusing overall.
> 
> But again... I seriously doubt any real user cares. I'll look into the
> history around this a bit more, but I'm very disinclined to think it's
> worth the reviewer time to try and push it more broadly...
> 
> This KC code also depends on CONFIG_HZ_PERIODIC, which no distro ships,
> so any user must necessarily be building their own kernel.
> 
>>> Pedantically, it's a user visable behavior change: today, the user
>>> can pass absurd values for sec and nsec, and everything works so long as
>>> the math works out to positive ticks (e.g. sec=ULONG_MAX/HZ,
>>> nsec=2*HZ*NSEC_PER_SEC).
>>>
>>> If it was just that, it wouldn't really matter IMO, but...
>>>
>>>> 	dev_dbg(&pps->dev, "timeout %lld.%09d\n",
>>>> 			(long long) fdata->timeout.sec,
>>>> 			fdata->timeout.nsec);
>>>> 		
>>>> 	ticks = fdata->timeout.sec * HZ;
>>>
>>> ...the multiplication by HZ could also overflow even if sec is positive,
>>> so I think userspace would still be able to trigger the splat this way.
>>>
>>>> 	ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>>>>
>>>> 	if (ticks > 0) {
>>
>> We can do as follow:
>>
>> 	/* Safe conversion using standard kernel API */
>> 	ts.tv_sec = fdata->timeout.sec;
>> 	ts.tv_nsec = fdata->timeout.nsec;
>> 	ticks = timespec64_to_jiffies(&ts);
> 
> Ah that helper is nicer, thanks.
> 
> This plus the (tv_sec < 0) change should be sufficient, I'll send that
> along soon unless you reply that you want the tv_nsec check too.

I agree with you.

>> 	if (ticks > 0) {
>> 		err = wait_event_interruptible_timeout(
>> 				pps->queue,
>> 				ev != pps->last_ev,
>> 				ticks);
>> 	}
>>
>> Ciao,
>>
>> Rodolfo
>>
>> -- 
>> GNU/Linux Solutions                  e-mail: giometti@enneenne.com
>> Linux Device Driver                          giometti@linux.it
>> Embedded Systems                     phone:  +39 349 2432127
>> UNIX programming

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
