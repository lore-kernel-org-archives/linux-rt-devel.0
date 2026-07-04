Received: from smtpdh18-1.aruba.it (smtpdh18-1.aruba.it [62.149.155.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE52309AA
	for <linux-rt-devel@lists.linux.dev>; Sat,  4 Jul 2026 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783144437; cv=none; b=VbHJPH6aIh++XMt5c/rhOIo5JTJB+EFoUTz9K7edtBpcT/hsTXRU9Bp9YmDR/hfJviH0fly++t9SIB5eu/3LgHaVEGK6sxB7e0zOB5KgPzI8rPfUZtVKKnj+blYWUdxPgXlJQ9G8OBRkmpfhsbCd65rCJuMGl+ohhrOhP1htDw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783144437; c=relaxed/simple;
	bh=UXIKzBzKPdf21Qc9DiWOMV4tdX2oYw6WjbznwvP6WJ4=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:Cc:To:
	 In-Reply-To:Content-Type; b=MPqquj3nNVrWHvBQWpoUSUJwxzjqcxSbwVHjJKrqalDA1s+9od3P2pxBP5nc9b26d7KSh3AQLD+tLn/yQg8cawD1dlQq1pXEmoSVaBZ4sZuI+Rsu/pG71Pk9XU6Rq/TptlEPPT80CcdTeXLKRdm52B4nA3ghL9Zk1IzOE6wvCB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=T+ShW3qA; arc=none smtp.client-ip=62.149.155.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="T+ShW3qA"
Received: from [192.168.0.186] ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id ftGywsdGZ5SteftGywlwnZ; Sat, 04 Jul 2026 07:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1783144242; bh=UXIKzBzKPdf21Qc9DiWOMV4tdX2oYw6WjbznwvP6WJ4=;
	h=Date:MIME-Version:Subject:From:To:Content-Type;
	b=T+ShW3qAfwPmi2YP2zI4M7tUHCyrhbZUZN3hjMQ+qbWSmcUATV7vbA/x3W8hyKn6m
	 TggXGakKnq7FoOPE8e3w3oULEmvgkjd+8uMu0FXBrx8QvuKb1TYnmZbGtNWw2ka4WD
	 YojGocZhKvOEzlrpQIqQyL7EqlvX6iiciny/Ek7fi+RkbxHiYZS9eiqBGGvGya+H+6
	 K4jejYQ5tLDblY7RPwXtMpFZs8L8DXa4Ohm9QhUF3CWlqwJo3NtSeeNEG1OZe0PV0K
	 3drwAJYQf8do3RouoVP339c/yxNeH8BTC6q7ZgzEm4LG7uk9jEG9NUGwG2EPo4cmPx
	 6yS/68ZMe6fLA==
Message-ID: <0b4b22bb-1f17-4e13-aa17-ea13476541c9@enneenne.com>
Date: Sat, 4 Jul 2026 07:50:38 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] pps: pps-gpio: split IRQ handler into hardirq
 timestamper + threaded handler
Content-Language: en-US
References: <cover.1780359378.git.calvin@wbinvd.org>
 <2e32729029fbf6977ecf04665eb00f2efd3e2c17.1780359378.git.calvin@wbinvd.org>
 <20260602063650.LWatIBPk@linutronix.de>
 <79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-online.de>
 <F4693DE2-E36F-4157-BB7B-A98A7C1C76E3@by-online.de>
From: Rodolfo Giometti <giometti@enneenne.com>
Cc: Michael Byczkowski <by@by-online.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Clark Williams <clrkwllms@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Eliav Farber <farbere@amazon.com>, Ingo Molnar <mingo@kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Thomas Gleixner <tglx@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <F4693DE2-E36F-4157-BB7B-A98A7C1C76E3@by-online.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKVY4s4OIjMWCa/UOYN/Hx9wttT1NG1/rLFcpkf6a2m6OrffjnUqw6U5mPOogYxBm40Qju4IiUPtek6CxkZ1JDGbIXQ7lFqXVUstlQ0j8gj72L/ewHd8
 6UbagXcEtN0+XPNkm32EgSwiwtyuXAcLTThSJjTwJzxKTym00uUUUgv/vJmb0awXGZ6R87v7JAl0wTR28r9AEQ8q9O1da7ptZ9cPWLS1ED5yHrCEaIfEd8hj
 7xD33hX7CsXF4dnZpEP3ui6XdnMHMaDxbMii6kXT7pWIySEuTtXWwVoJq1DmgD4IWEOlS2vG22DviSZIDYf4orQDmZAiWkEm77YGmwDollzt3iQ2E1+I+5l9
 TKaE9Cf72EQne4kLi6m8op95+4Sk1cxze95Te8IG8b3QIdKTRzp0LkvR+P8fHFGTr1eDquIeN9zr6fAi2z58sjkk6wCbrSq97D0R3b6+LgC9xUScZJhtinck
 IJMojTiVQDgHK45pjrtOVh+2D6eawt+WwGF0MWQG0IkIgss5Z5pEbHHXUVBuG09ShU0OoOftRaRGU+NMTsRmNRMsE08L+rjVlhwnMYCTydKp7GqC1u4toKwV
 pViPbRQ4ytauU4Yl6+m6bi9I

Hi Andrew,

Could you please pick this patch up for the 7.3 merge window via the -mm tree?

Since the PPS subsystem doesn't have its own dedicated git tree, routing it 
through -mm is the standard path. The patch already has my Acked-by, along with 
all the necessary reviews and test tags.

Thanks,
Rodolfo

On 03/07/2026 20:20, Michael Byczkowski wrote:
> Dear All,
> 
> Now that 7.2-rc1 is out and this didn't make the merge window, could someone please confirm which tree will carry this for 7.3?
> So far, the patch has been:
>      • Reviewed-by: Sebastian Andrzej Siewior (Jun 2)
>      • Acked-by: Rodolfo Giometti (PPS maintainer, from earlier revisions)
>      • Tested-by from Calvin Owens and myself
> 
> I'm not sure whether it should go via drivers/pps (Rodolfo), the rt tree, or -mm. Happy to help route it wherever makes sense.
> lore: https://lore.kernel.org/lkml/79BC1B96-FD2C-4191-8766-6C46BF8A1089@by-online.de/
> 
> Thank you very much and best regards,
> Michael
> 
> 
> 
>> On 3. Jun 2026, at 19:29, Michael Byczkowski <by@by-online.de> wrote:
>>
>> Thank you Sebastian, and thank you Calvin for relaying. I appreciate the
>> thorough review that got this to the right shape.
>>
>> Best regards,
>> Michael
>>
>>
>>> On 2. Jun 2026, at 08:36, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>>>
>>> On 2026-06-01 17:44:09 [-0700], Calvin Owens wrote:
>>>> From: Michael Byczkowski <by@by-online.de>
>>>>
>>>> Split the pps-gpio interrupt handler into a primary (hardirq) handler
>>>> that captures the PPS timestamp at interrupt entry, and a threaded
>>>> handler that processes the event. This produces the same two-part
>>>> handler structure on both PREEMPT_RT and non-RT kernels.
>>>>
>>>> On non-RT kernels the threaded portion runs immediately after the
>>>> primary, with no behavioral change compared to the previous
>>>> single-handler implementation.
>>>>
>>>> On PREEMPT_RT, where interrupt handlers are force-threaded by default,
>>>> the previous single-handler implementation captured the timestamp
>>>> inside the threaded portion, after IRQ-thread scheduling delay. With
>>>> the split, the timestamp is captured in true hardirq context as it is
>>>> on non-RT kernels, eliminating a significant source of PPS jitter on
>>>> RT systems.
>>>>
>>>> Tested-by: Michael Byczkowski <by@by-online.de>
>>>> Tested-by: Calvin Owens <calvin@wbinvd.org>
>>>> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
>>>> Signed-off-by: Michael Byczkowski <by@by-online.de>
>>>> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
>>>> ---
>>>
>>> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>>>
>>> Sebastian
>>
> 


-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming
