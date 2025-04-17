Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA6022ACCE
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889481; cv=none; b=t+DEvYmy9X5wvvANAoMg6wHNRtETBTmZbXfVzYPU8cIOFjrFoAWt+h/9dJAYjFVOveDHpHRJqYY0KwbfTzUOmodo/clxzg/Ux2ygxnDzE8v9jDviOtUmqP8g6tPKainFzIW3779N3rtYKSSoM/hGrmaWIxZImv3H9ZVJ9fnMgrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889481; c=relaxed/simple;
	bh=1RJ/CV4N2DVmoWSVYLenzw7jqr9hxjWOzIF5NG74DiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYr9SKjeBviXJDe+w85dBaQra9bND9iw3Gmxe+QO3S6Dwsc4UPHcxSSgsmSjs0+EfTKfsvOIbxyXU2numCB4K1Ra68ULYRXf9M4Rh3Gnnid8HDjvHmbMDtz/hGOzUbOw2VUTQhqhhjKHWDPY+k8Axw0BQJae7YAAuHdeqbhOhQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cJBfCifU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cJBfCifU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744889478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEHMEBHjvrO7PpcasZwzrx+ZnESuX/sK9Us9aU6KrI0=;
	b=cJBfCifU/8GR5a9KHp58YdvWgVGzs9/FVv0D26+ICX++ZQZd6A5yFk6YbgVZrMFFZD7RBE
	IURO00vo18IUioeZ0zYpOheXozSeulvIefJ9jWk1yWRKAP87MvGB6q4FtOZ82aj3WX+r1t
	4NDvo6UdAOCMjWD9jYU8IKjg3+GQo9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-_UidLYO6OnCgom4ePVzpCg-1; Thu, 17 Apr 2025 07:31:15 -0400
X-MC-Unique: _UidLYO6OnCgom4ePVzpCg-1
X-Mimecast-MFC-AGG-ID: _UidLYO6OnCgom4ePVzpCg_1744889474
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3978ef9a284so223356f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Apr 2025 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744889474; x=1745494274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEHMEBHjvrO7PpcasZwzrx+ZnESuX/sK9Us9aU6KrI0=;
        b=oJvd4PLsHueoQR9hdBMY4tIcPqKMSawAyj2zM1yIPuA0PHhVAudMc9yhNbbnQi3Wew
         yQ50Fdno1w8dJe/41hPwYuQCVn6rOZ6PT//fT1K8hQIv8gwe33Y1Tdnbzp/7xkwQ86pw
         MiD2pEzGC93aZbcg6aun3K6jvxiKHFpN2Yx4XDvByOq2gvmCXbyIHg7Sql74a3m9qOeU
         H1g9wX9FBnTyarislQ+cmyCYhWIpVLFhC04+V8ScxYxDLs5v7SIuAwyo7D4GHV1eGw4w
         vr63MXbvpTLJGsHrCAGLmoUwVCatoFKChYdLsUGdaGsgsUJOp6+Q9+qc/5beijCsvuSI
         pQ2A==
X-Forwarded-Encrypted: i=1; AJvYcCUmJZqtyLf5wWyVenfrbH6P3R3kO+QYiZf6uBaIQSqi0+Q50jeDvXvIlXrB5AzrChZftT5goZwJvE8g1RPW4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWoDA4XU+w60a/z6W5OV+MfTQmW6tL+z5xRyRnRO8c5qtL+rz8
	5ToXSO5BkPZq+4W4Ew9DnbLIqquQqzKQwjuJRY5bbD4YTt+kwKIshuLwIt+F2AzeTybYwbHMUGq
	5jY3cKs2IVPRJaYbzs1AkhMPz7pAJBiwInmSTObY7EJKnfBLvXVM/IwtHpxGwwbk0
X-Gm-Gg: ASbGnct6SKOj2Z6Tl7ourG4NgH7tuh8AqRKI4ifro2UUOvAro9F69mJZh6qbFyzOEHD
	SwedjFNP3Trxyqs+OZbQ/Cg+MLNwMGCe531gN2x7gyySkNr8JBepBqJlssSg9NXE072ELA1FSM2
	1T0A8oXtHhalinrgezY3Mk9y8vhChDztaZ7Y97PGiMZblTmgCFzo72fA2T681lig0RJcux2zfPN
	JHgLm4QY4r0CEbQmufmCDtnjy1nzBvvhidTgsQtNUMnXU5teVv7GVC3FwoUjYPFfyXzvaWWbJVN
	YIaWHHucqM4a8SnzJ3vEUom5DxjcekAIhS/jgQST1A==
X-Received: by 2002:a05:6000:1a8d:b0:39a:c9ac:cd3a with SMTP id ffacd0b85a97d-39ee5bb18cemr4883769f8f.51.1744889474127;
        Thu, 17 Apr 2025 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVh2XSH9ICxYx7OtIie2cVOvMLCFJqq0rQsaoeQZZs4AayYJ6WUwXCYLPEbxTa1fEk3zWwYA==
X-Received: by 2002:a05:6000:1a8d:b0:39a:c9ac:cd3a with SMTP id ffacd0b85a97d-39ee5bb18cemr4883732f8f.51.1744889473682;
        Thu, 17 Apr 2025 04:31:13 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf43d053sm20106093f8f.68.2025.04.17.04.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 04:31:13 -0700 (PDT)
Message-ID: <090c7522-34a0-4e9b-bfb8-1b8d5698b902@redhat.com>
Date: Thu, 17 Apr 2025 13:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-14-bigeasy@linutronix.de>
 <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>
 <20250417104736.pD2sMYXv@linutronix.de>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250417104736.pD2sMYXv@linutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Lt1krwmT4UZtuHV-O9Y2ijiPR9ABKay_2ITvz1kVGfU_1744889474
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/25 12:47 PM, Sebastian Andrzej Siewior wrote:
> + Ingo/ PeterZ for sched, see below.
> 
> On 2025-04-17 10:29:05 [+0200], Paolo Abeni wrote:
>>
>> How many of such recursion counters do you foresee will be needed?
> 
> I audited the static per-CPU variables and I am done with this series. I
> need to go through the dynamic allocations of per-CPU but I don't expect
> to see any there.
> 
>> AFAICS this one does not fit the existing hole anymore; the binary
>> layout before this series is:
>>
>>  struct netdev_xmit {
>>                 /* typedef u16 -> __u16 */ short unsigned int recursion;
>>                 /*  2442     2 */
>>                 /* typedef u8 -> __u8 */ unsigned char      more;
>>                 /*  2444     1 */
>>                 /* typedef u8 -> __u8 */ unsigned char
>> skip_txqueue;                /*  2445     1 */
>>         } net_xmit; /*  2442     4 */
>>
>>         /* XXX 2 bytes hole, try to pack */
>>
>> and this series already added 2 u8 fields. Since all the recursion
>> counters could be represented with less than 8 bits, perhaps using a
>> bitfield here could be worthy?!?
> 
> The u8 is nice as the CPU can access in one go. The :4 counting fields
> (or so) are usually loaded and shifted so there is a bit more assembly.
> We should be able to shorten "recursion" down to an u8 as goes to 8
> only.
> 
> I still used holes according to pahole on my RT build (the non-RT
> shouldn't change):> 

Please disregard my comment here. I misread the netdevice_xmit struct
layout. You are right it still fit an hole.

>>> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
>>> index 5b38143659249..5f01f567c934d 100644
>>> --- a/net/sched/act_mirred.c
>>> +++ b/net/sched/act_mirred.c
>>> @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
>>>  static DEFINE_SPINLOCK(mirred_list_lock);
>>>  
>>>  #define MIRRED_NEST_LIMIT    4
>>> -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
>>> +
>>> +#ifndef CONFIG_PREEMPT_RT
>>> +static u8 tcf_mirred_nest_level_inc_return(void)
>>> +{
>>> +	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
>>> +}
>>> +
>>> +static void tcf_mirred_nest_level_dec(void)
>>> +{
>>> +	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
>>> +}
>>> +
>>> +#else
>>> +static u8 tcf_mirred_nest_level_inc_return(void)
>>> +{
>>> +	return current->net_xmit.sched_mirred_nest++;
>>> +}
>>> +
>>> +static void tcf_mirred_nest_level_dec(void)
>>> +{
>>> +	current->net_xmit.sched_mirred_nest--;
>>> +}
>>> +#endif
>>
>> There are already a few of this construct. Perhaps it would be worthy to
>> implement a netdev_xmit() helper returning a ptr to the whole struct and
>> use it to reduce the number of #ifdef
> 
> While I introduced this in the beginning, Jakub asked if there would be
> much difference doing this and I said on x86 at least one opcode because
> it replaces "var++" with "get-var, inc-var". I didn't hear back on this
> so I assumed "keep it".

I forgot about that discussion. Given that note, I'm ok with the current
implementation, but please add a comment (or a sentence in the commit
message) for future memory.

Thanks!

Paolo

