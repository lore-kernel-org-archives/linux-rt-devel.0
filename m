Received: from smtpdh19-2.aruba.it (smtpdh19-2.aruba.it [62.149.155.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB05382F31
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Jun 2026 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297512; cv=none; b=hxCbSxLaTAwt+dN81nXpuk3aKR2gnNUYpGkENc5J/cPDApMHKtNyWtyVhGdGPiamGJwXtl2E7pUnK4b+bgIs2EvtuDUrzlNCWNU/Ch6ZOrVw53W0+d5ynxGNxMGhU7bulfP8qrAarpD6g6E8boSbMmsDw6txS7kiJZnWTt+/VKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297512; c=relaxed/simple;
	bh=0BchrLKYZWvWm7Eg9H7ZInuZ8FrJcoC+l9Oo+L9KzdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U78NlCzUZAzFg2e+Yw1aZx7hun2A4VL10kArAeDH9ov3bJtOHjWLdnYUbji0Vv05Hcu+OY82J7nZ/ts0taHPMQ2ZL8BBMVCF50scHvdYMDLFoetrE/IlDV/jKMbTCEutWEozpBXkzg4btwJOIGlImvEnYXTo6SZgsnivuW04vtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=h6l4lvBr; arc=none smtp.client-ip=62.149.155.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="h6l4lvBr"
Received: from [192.168.0.186] ([109.118.80.246])
	by Aruba SMTP with ESMTPSA
	id Twhnwd60FclBZTwhowlKcj; Mon, 01 Jun 2026 09:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1780297501; bh=0BchrLKYZWvWm7Eg9H7ZInuZ8FrJcoC+l9Oo+L9KzdI=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=h6l4lvBrgarjvlCqodY6XGrr66rG+3Mj6UxoG1UZXzrz6VmGvzL1JjBITftVLDVQq
	 u9aZXlunSuqpvvQ9NcBNE8ZME1axrrUJiiibARQSk2W5jfDCM4wd9EkOw3goq01NC1
	 HKTDaDNmZs7uJF+iYbIb2bnPXIEvjqYwnOEcMEf+JWIwipdkdC7gL57OAC2O18W4Yj
	 zEQR6QeJF9zlJpy5GyP8HwFgWYScfCiofNCJGcrLVWnx/sckkSd7FTS4R/m+7Vuirz
	 /WaBPKr0LbxBdMsRBnx8sM9pjvygvNrPqFYNUT6hUj5YE7rPe756rSKSU2feTKfFmS
	 zeYqwJL8vVaCA==
Message-ID: <ee1b67f4-1627-4999-be4e-e21ac2dff9dd@enneenne.com>
Date: Mon, 1 Jun 2026 09:04:59 +0200
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
From: Rodolfo Giometti <giometti@enneenne.com>
In-Reply-To: <ahr6IHpbRRlpTMbp@mozart.vkv.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNzaGpdUK9Uwr6Yswj3RhG7/jAsa8UDXF03tNWMs65QM7zK859GrhOSgwUNN5wtgclgb+98gbXuy06UC0C6JpXw1Q2ZXKvV55GvsuUVN4ERkzUSpnCW/
 GkTaRil72gvJavj5dac5W1OjNAH4UGxAqziOH2OGi1I1/scuPI9U9eAGJfQgm5aSkuXWEaHpiEqmKWqzw+Wqqo8B+MM9U9p4g22Wa82R1YMHhfURnLznOEG/
 OFIG3yl1E47B/4z6vMOQgJFYVgy6cYEyc9mZeSS1lSocnmTD9+pyg6Cb4Y0eZMCDPnaFQirjDBi6DHffcHv7HLScqFshgx8ekpCfXYDWIl3I6Zj0ShFsrMYQ
 baNkOCxulEhGYL3vcHcN5yyYLKdDfmJrIHwdjOL1uXFnYE//cXOLsU+rbQRCVm2jPRcGUMUM

On 30/05/2026 16:54, Calvin Owens wrote:
> On Saturday 05/30 at 11:50 +0200, Rodolfo Giometti wrote:
>> On 29/05/2026 18:21, Calvin Owens wrote:
>>> If userspace passes a negative timeout to PPS_FETCH, it triggers a
>>> kernel splat from schedule_timeout():
>>>
>>>       schedule_timeout: wrong timeout value fffffffffff0bfb4
>>>       CPU: 17 UID: 0 PID: 4720 Comm: a.out Not tainted 7.1.0-rc5-x86-kvm-00150-g331d97e36b37 #1 PREEMPT_RT
>>>       Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-20240910_120124-localhost 04/01/2014
>>>       Call Trace:
>>>        <TASK>
>>>        dump_stack_lvl+0x4b/0x70
>>>        schedule_timeout+0xb7/0xe0
>>>        pps_cdev_pps_fetch.isra.0+0x93/0x150
>>>        pps_cdev_ioctl+0x70/0x310
>>>        __x64_sys_ioctl+0x7b/0xc0
>>>        do_syscall_64+0xb6/0xfc0
>>>        entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>
>>> Sashiko imagines this to be some sort of security problem, which is
>>> obviously really silly. But I think it is still worth fixing, so buggy
>>> userspace code can't trigger the splat.
>>>
>>> Silence the splat by skipping the wait if the ticks count is negative.
>>> The current behavior is to return -ETIMEDOUT in that case, so keep that
>>> return value in case any userspace code might rely on it.
>>>
>>> Fixes: eae9d2ba0cfc ("LinuxPPS: core support")
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Closes: https://sashiko.dev/#/patchset/cover.1779733602.git.calvin%40wbinvd.org?part=3
>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> 
> Hi Rodolfo,
> 
> Thanks for taking a look at this and the others.
> 
>>> ---
>>>    drivers/pps/pps.c | 6 ++++--
>>>    1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
>>> index de1122bb69ea..6755901fbdae 100644
>>> --- a/drivers/pps/pps.c
>>> +++ b/drivers/pps/pps.c
>>> @@ -65,17 +65,19 @@ static int pps_cdev_pps_fetch(struct pps_device *pps, struct pps_fdata *fdata)
>>>    	if (fdata->timeout.flags & PPS_TIME_INVALID)
>>>    		err = wait_event_interruptible(pps->queue,
>>>    				ev != pps->last_ev);
>>>    	else {
>>> -		unsigned long ticks;
>>> +		long ticks;
>>>    		dev_dbg(&pps->dev, "timeout %lld.%09d\n",
>>>    				(long long) fdata->timeout.sec,
>>>    				fdata->timeout.nsec);
>>>    		ticks = fdata->timeout.sec * HZ;
>>>    		ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>>> -		if (ticks != 0) {
>>> +		if (ticks < 0) {
>>> +			return -ETIMEDOUT;
>>> +		} else if (ticks > 0) {
>>>    			err = wait_event_interruptible_timeout(
>>>    					pps->queue,
>>>    					ev != pps->last_ev,
>>>    					ticks);
>>
>> Should the problem originate from user-space data, I deem it more
>> appropriate to verify them directly, rather than relying on computed data.
>>
>> 	unsigned long ticks;
>>
>> 	if (fdata->timeout.sec < 0 || fdata->timeout.nsec < 0)
>> 		return -ETIMEDOUT;
> 
> I agree your way is nicer to read.

We can also do as follow:

	/* Canonical validation of nanoseconds */
	if (fdata->timeout.nsec < 0 || fdata->timeout.nsec >= NSEC_PER_SEC)
		return -EINVAL;

	/* Preserve historical API behavior for negative seconds */
	if (fdata->timeout.sec < 0)
		return -ETIMEDOUT;

> Pedantically, it's a user visable behavior change: today, the user
> can pass absurd values for sec and nsec, and everything works so long as
> the math works out to positive ticks (e.g. sec=ULONG_MAX/HZ,
> nsec=2*HZ*NSEC_PER_SEC).
> 
> If it was just that, it wouldn't really matter IMO, but...
> 
>> 	dev_dbg(&pps->dev, "timeout %lld.%09d\n",
>> 			(long long) fdata->timeout.sec,
>> 			fdata->timeout.nsec);
>> 		
>> 	ticks = fdata->timeout.sec * HZ;
> 
> ...the multiplication by HZ could also overflow even if sec is positive,
> so I think userspace would still be able to trigger the splat this way.
> 
>> 	ticks += fdata->timeout.nsec / (NSEC_PER_SEC / HZ);
>>
>> 	if (ticks > 0) {

We can do as follow:

	/* Safe conversion using standard kernel API */
	ts.tv_sec = fdata->timeout.sec;
	ts.tv_nsec = fdata->timeout.nsec;
	ticks = timespec64_to_jiffies(&ts);

	if (ticks > 0) {
		err = wait_event_interruptible_timeout(
				pps->queue,
				ev != pps->last_ev,
				ticks);
	}

Ciao,

Rodolfo

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
