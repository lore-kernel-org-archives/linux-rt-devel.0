Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D11264FBB
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Mar 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741872202; cv=none; b=Z/uvdGcPfoEjRPRWGsRstpqlm2lvFAT1GMz3IUg9kquUMnd5PTD9dh76IuWt2ZTIfMt/BDLIwQpsD70W6i4IMksfQcH4U5WuAkUKhx2Mi5NMDHFQwoczDbC9a5qq4K7LTeVKkypB3iluJxqUa+FeIVhjwkiu3Kp9KewPMOauwGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741872202; c=relaxed/simple;
	bh=L9XV4Y35jCGJR88ml9UUQb7dVRefaM5GCbsJTE6YUU0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DsZg1yCWfdLL2OeptqIq6oab4igsSU3qpnwpO/W4qCoEvTOlgq2MA31kxl5hWvMkBx7LRpCkM6XP1kBd405BAF8Iog6QmQg/PM/tusWkmI6YA6J3JXeq+CJj+AjvNc9KYuzRh9evBHeWj0Bo7MYH3tSUgRIdKzQonhb2y70UwYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so138576866b.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 13 Mar 2025 06:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741872198; x=1742476998;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NrAc/yxVGn328P5W1Z/q6F6VxfIaN5sM0NXgadXTzU=;
        b=VGIv1QtfrXozlawO59oBFn96SigLI0QNxt3Ctdh4ocn9vegP9+UIuOi8QcOpe+y5Wg
         arFL0govW1iPim2h1Df+24OxxlfCATcQTQ9Ig6TPCvi2dDZRKv23wreGZiD8cGgg974U
         3cqvV073LX0qn03lwjlIQ4VuPLmW0Hdfh2wdItElUHP7V3JgHX3guGGv38wZAnKZBncc
         OYFfHpKMbKr5GbjJtwA7J5BqKlyB7AgfJWtQKzQcKFWGxdROehLXOBONV2M40fgnCeW8
         HDsmJOOYzqFMXCfhstd4JJ2cKyAkXI88FkC3X613Nbe+ve5W2Tpoh/3qJptGPVZYGkvw
         Io4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjyqJLD6eysZEQpc5HFa/LFdaICWXI7UhSVR1iueBjaeq/O2s/Lu+Yh8RQnGOKOMtOqo+5fEbRtMEOfE29FQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyDbYSSaIkswOWMjyNIoSJLWKrypMzc1fEkAP0QtYTEFGkXpWJF
	kK1uu/R0/RU7sakY7QiIXmBJr5qY6hb1zn2yGSpI/JKQFmp0H95pFmBrQU/J
X-Gm-Gg: ASbGncsrzsUfndnNCiv6YVQ5zbJurmzdwMQmbVZ9G7rUh/XfW9yQ5vzO4Yl8hbD50Ms
	mfnSI33sF+ezjapPeZE3tT98DH3cpagcPIevPz2/ZG2AwjnDxlI3kOzfCtbv3yMft+0Vvn1Jmjb
	BqotCpoNwdkKIg1WY8NjM12wZ4tEMmqZtQdcK70oYhB5TuwEsia0lb6INIZB39jt1BQeRBQqrep
	JigoVd0xAh6F3JoixAFTk0yuWkjX4x+cnBuxPNSF1B0kN+/LWepmn9796oHLxkcj01rimbmnEwN
	a2Fj/GBsbNEe3Y3xP/K9d9V7o5q6fi6YRPVihlgDeE2IrtO+2MhEUXejBk9fw0otVHiXi04/NyF
	M
X-Google-Smtp-Source: AGHT+IEjQzb1AHuzjynMSitk2YWQDCkYEnUI4hH+R7apJ0UT/yB4RFSQJX9AuB8b3ih9SjCf1cXDFQ==
X-Received: by 2002:a17:907:930c:b0:ac2:a447:770b with SMTP id a640c23a62f3a-ac2b9de9602mr1268316566b.21.1741872197966;
        Thu, 13 Mar 2025 06:23:17 -0700 (PDT)
Received: from [192.168.0.13] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aecffsm80073166b.25.2025.03.13.06.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 06:23:17 -0700 (PDT)
Message-ID: <1d72e5df-921b-4027-bf9c-ca374c3a09d1@ovn.org>
Date: Thu, 13 Mar 2025 14:23:16 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, dev@openvswitch.org,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next 11/18] openvswitch: Use nested-BH
 locking for ovs_actions.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-12-bigeasy@linutronix.de>
 <9a1ededa-8b1f-4118-94b4-d69df766c61e@ovn.org>
 <20250310144459.wjPdPtUo@linutronix.de>
 <fd4c8167-0c2d-4f5f-bf70-1efcdf3de2fb@ovn.org>
 <20250313115018.7xe77nJ-@linutronix.de>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250313115018.7xe77nJ-@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 12:50, Sebastian Andrzej Siewior wrote:
> On 2025-03-10 17:56:09 [+0100], Ilya Maximets wrote:
>>>>> +		local_lock_nested_bh(&ovs_actions.bh_lock);
>>>>
>>>> Wouldn't this cause a warning when we're in a syscall/process context?
>>>
>>> My understanding is that is only invoked in softirq context. Did I
>>> misunderstood it?
>>
>> It can be called from the syscall/process context while processing
>> OVS_PACKET_CMD_EXECUTE request.
>>
>>> Otherwise that this_cpu_ptr() above should complain
>>> that preemption is not disabled and if preemption is indeed not disabled
>>> how do you ensure that you don't get preempted after the
>>> __this_cpu_inc_return() in several tasks (at the same time) leading to
>>> exceeding the OVS_RECURSION_LIMIT?
>>
>> We disable BH in this case, so it should be safe (on non-RT).  See the
>> ovs_packet_cmd_execute() for more details.
> 
> Yes, exactly. So if BH is disabled then local_lock_nested_bh() can
> safely acquire a per-CPU spinlock on PREEMPT_RT here. This basically
> mimics the local_bh_disable() behaviour in terms of exclusive data
> structures on a smaller scope.

OK.  I missed that is_softirq() returns true when BH is disabled manually.

> 
>>>>> +		ovs_act->owner = current;
>>>>> +	}
>>>>> +
>>>>>  	level = __this_cpu_inc_return(ovs_actions.exec_level);
>>>>>  	if (unlikely(level > OVS_RECURSION_LIMIT)) {
>>>>>  		net_crit_ratelimited("ovs: recursion limit reached on datapath %s, probable configuration error\n",
>>>>> @@ -1710,5 +1718,10 @@ int ovs_execute_actions(struct datapath *dp, struct sk_buff *skb,
>>>>>  
>>>>>  out:
>>>>>  	__this_cpu_dec(ovs_actions.exec_level);
>>>>> +
>>>>> +	if (level == 1) {
>>>>> +		ovs_act->owner = NULL;
>>>>> +		local_unlock_nested_bh(&ovs_actions.bh_lock);
>>>>> +	}
>>>>
>>>> Seems dangerous to lock every time the owner changes but unlock only
>>>> once on level 1.  Even if this works fine, it seems unnecessarily
>>>> complicated.  Maybe it's better to just lock once before calling
>>>> ovs_execute_actions() instead?
>>>
>>> My understanding is this can be invoked recursively. That means on first
>>> invocation owner == NULL and then you acquire the lock at which point
>>> exec_level goes 0->1. On the recursive invocation owner == current and
>>> you skip the lock but exec_level goes 1 -> 2.
>>> On your return path once level becomes 1, then it means that dec made it
>>> go 1 -> 0, you unlock the lock.
>>
>> My point is: why locking here with some extra non-obvious logic of owner
>> tracking if we can lock (unconditionally?) in ovs_packet_cmd_execute() and
>> ovs_dp_process_packet() instead?  We already disable BH in one of those
>> and take appropriate RCU locks in both.  So, feels like a better place
>> for the extra locking if necessary.  We will also not need to move around
>> any code in actions.c if the code there is guaranteed to be safe by holding
>> locks outside of it.
> 
> I think I was considering it but dropped it because it looks like one
> can call the other.
> ovs_packet_cmd_execute() is an unique entry to ovs_execute_actions().
> This could the lock unconditionally.
> Then we have ovs_dp_process_packet() as the second entry point towards
> ovs_execute_actions() and is the tricky one. One originates from
> netdev_frame_hook() which the "normal" packet receiving.
> Then within ovs_execute_actions() there is ovs_vport_send() which could
> use internal_dev_recv() for forwarding. This one throws the packet into
> the networking stack so it could come back via netdev_frame_hook().
> Then there is this internal forwarding via internal_dev_xmit() which
> also ends up in ovs_execute_actions(). Here I don't know if this can
> originate from within the recursion.

It's true that ovs_packet_cmd_execute() can not be re-intered, while
ovs_dp_process_packet() can be re-entered if the packet leaves OVS and
then comes back from another port.  It's still better to handle all the
locking within datapath.c and not lock for RT in actions.c and for non-RT
in datapath.c.

> 
> After looking at this and seeing the internal_dev_recv() I decided to
> move it to within ovs_execute_actions() where the recursion check itself
> is.
> 
>>> The locking part happens only on PREEMPT_RT because !PREEMPT_RT has
>>> softirqs disabled which guarantee that there will be no preemption.
>>>
>>> tools/testing/selftests/net/openvswitch should cover this?
>>
>> It's not a comprehensive test suite, it covers some cases, but it
>> doesn't test anything related to preemptions specifically.
> 
> From looking at the traces, everything originates from
> netdev_frame_hook() and there is sometimes one recursion from within
> ovs_execute_actions(). I haven't seen anything else.
> 
>>>> Also, the name of the struct ovs_action doesn't make a lot of sense,
>>>> I'd suggest to call it pcpu_storage or something like that instead.
>>>> I.e. have a more generic name as the fields inside are not directly
>>>> related to each other.
>>>
>>> Understood. ovs_pcpu_storage maybe?
>>
>> It's OK, I guess, but see also a point about locking inside datapath.c
>> instead and probably not needing to change anything in actions.c.
> 
> If you say that adding a lock to ovs_dp_process_packet() and another to
> ovs_packet_cmd_execute() then I can certainly update. However based on
> what I wrote above, I am not sure.

I think, it's better if we keep all the locks in datapath.c and let
actions.c assume that all the operations are always safe as it was
originally intended.

Cc: Aaron and Eelco, in case they have some thoughts on this as well.

Best regards, Ilya Maximets.
