Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792666550;
	b=n9Ch2R9rXBPdh1uL0heYkE0zcV/s+WYfaR5geTcl2wRHVPeAfnhQBJpAKUEtM9KQM/yP
	 Y8dEcIiItpQHO9wW5GKpD3tZC8QxMHXigWPYG8iydlvvlDxq9HDX3Bn9c3quVOc3PCKcz
	 Fwo/n0Qe/cjIQdT6iKDfNHpzd3+xd6lb6rzcxAdpEHqFRYN3hgSJ8qx+lpe+4qhxCuy/3
	 xgoLsgdIsT/tBxORtfk+gvhcjoJM3O7Dd7oZxBsUuXnpuKuz4Pub0pGzNFRsrj3aKu6zp
	 ofntBEb2fPPhaWHo7RKrgZWRB4P26z4VflH3aya30qsDAeaVuwAbejzboH0W9cRciBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792666550;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	b=D8lwEq9Ao+DtxAwvt8f4S82vYwRAIKRNulv6PKiDjljJfqsNgdPEoAjqYxe+S5W76FSO
	 rEaNVFguXBrFjNiKDZJtdRJ3R36mAz8jdRDIZAE+0oepoZz8Igu5aZUVOuOUFg5oszeou
	 lGcQagU3qNoQMopdpNyaNC1FpVPOcmdbaAApQ0R0aVjLkYgt18Lck4aQWH6r6ZVaDhVXM
	 QqdrmPk3JUimQRg/oG1wlqN00oW9bv1KQ88Vs4vzBxQdO3nJqpcPuS3jKaONsFaPON4zy
	 kowcutQSKraZ18GnD4kW0Rulh/SYwZZxmwfiJ/b4GPsmmINO4enxzBM5u60II+AXotA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+ZYje5S;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0577606A31B
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 10:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0577606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h+ZYje5S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792666548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
	b=h+ZYje5SO2XMr6BucC2/qZiIXALm/3RrfW4ZnlDwK6d0zQat6wVsCiN5KTouFOnR4KxDqF
	H6IoZjL8D+v4xMy2P34wBA4XxGKjGU+GmRFKwYYPUhfKuhDLaw9bqKykTTbj03tjmpjxWG
	aHUpbNRq7DWeVhwDV0EWauOCUeD80Wo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-IhNyK57zMhyVfsg2cCP16g-1; Thu, 22 Oct 2026 10:54:41 +0000
X-MC-Unique: IhNyK57zMhyVfsg2cCP16g-1
X-Mimecast-MFC-AGG-ID: IhNyK57zMhyVfsg2cCP16g_1792666479
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dfdc0f491so973415f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 03:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792666479; x=1793271279;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m02LnQqAx90iQHNTDHgW+TeOE5dUtsPN+2XnmmAiXdA=;
        b=JCWM6/zuqu/7bV6py0hG6B+3zHaQMOtop9e7eFp04hr2LJseN/u4Mvnglz8QCQHoMA
         y1fq3srBylspNyek89DG8+30YIYRE32+ZRZT6dqt7ao6FAi0di6IcvF/eEnGOKvaY70E
         sGP4kMvgJKSKhrDb+AQKjeZ+6TVd6t20d7EuStHjqw7dBHJM57COEbWriSMVdr34Z1HQ
         3sJY17aMiL9jFQyqOuxKynwCKYgDNBSqGOHG0j4lIJZX7mwPf8OaWAxBGJcpYAplRarE
         pZ9Fd/0a3QCGoBItBtkZ2hlGFTlGu4PCKrSvwnqHy5VmQTnNtBDQfSiy6H/CLMN3cMIX
         5qRw==
X-Forwarded-Encrypted: i=1; AKwUvBzhYF2GwATbS5vba+MGFyVORIQhlvmZCeHdyoeIWdpGVQ4aW1F+mZNRYVAYJC6jGusoibeP+MCEX406XCdc7Q==@lists.linux.dev
X-Gm-Message-State: AFq9FYLkZx7jp9IVT+OWC4xmHKM8hFBpCpRHqvv+KGDtuo6LyYu0pAaS
	nN0iNBuzxvZmKcfmBbHxe6t54Cr5grz9GUH5wIZU7KvMayFy0deA5Zh749aQClJ3DvMFaZeahlm
	niipw3haURLXsmhXV36e6qcFThMnpOEIlcT9O9hcB56waxBa/FZdGvr6zagEpUtuXA9UH
X-Gm-Gg: AYBFou22+4SIkjUDmVT6QbZl+FIE7aS3i0HmgamO43Djgec0ClRdkB6Ace7CUuAFM2O
	/of8Z3/vZgRL70tjnXLe9zmrvQmNS8jNc6q50QECqf1FkQYALNEWPM4OyudPPRtd4n275QY3PL+
	tEuz+9TZGxMOKjqaeIO3nrXkXl2wDvjQWS1D4NuyWaSESTCp/H1B8LHjM5wsEH75Zc+OuuHeFjj
	63eUulqBbAaCRAs5fPb0VVyLj0BC96qXQGAFFbsmPLg6lIdoQGN6TjRYcw93gfqckNjnaitkiZv
	HOwKdh3M7eylBjuLwnLtUo/z5LRmJ6y2DU9BZlHNIRdOfrdjQRevmUXo5p+Yvy7GnG0bGtjpIQ=
	=
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id 5b1f17b1804b1-4a1fdd3d407mr99476235e9.29.1792666479366;
        Thu, 22 Oct 2026 03:54:39 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a1:b0:4a1:f0bc:90b with SMTP id 5b1f17b1804b1-4a1fdd3d407mr99475815e9.29.1792666478965;
        Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f02f1sm12856807f8f.3.2026.10.22.03.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 03:54:38 -0700 (PDT)
Message-ID: <8b9bc610-777b-4436-98a6-2428153cc5f2@redhat.com>
Date: Thu, 22 Oct 2026 12:54:36 +0200
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
Subject: Re: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
 ndo_setup_tc
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-4-poros@redhat.com>
 <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <CH3PR11MB566895E0410B0694F734EA7DAFE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HDbGzP6t1btQYtL1gZLJXiHsFVBmgsI5DSTKpJDytv0_1792666479
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/26 1:22 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Petr Oros <poros@redhat.com>
>> Sent: Monday, October 19, 2026 8:53 AM
>> To: netdev@vger.kernel.org
>> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Ertman, David M <david.m.ertman@intel.com>; Shiraz
>> Saleem <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>;
>> Maziarz, Kamil <kamil.maziarz@intel.com>; Rafal Rogalski
>> <rafalx.rogalski@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
>> linux-rdma@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Sebastian Andrzej
>> Siewior <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
>> Steven Rostedt <rostedt@goodmis.org>; Mateusz Palczewski
>> <mateusz.palczewski@intel.com>; linux-rt-devel@lists.linux.dev
>> Subject: [PATCH iwl-net 3/3] ice: do not block on the aux device lock in
>> ndo_setup_tc
>>
>> The TC_SETUP_QDISC_MQPRIO path of ice_setup_tc() takes the auxiliary
>> device lock to test whether the RDMA driver is bound, and ndo_setup_tc()
>> runs with the RTNL lock held. This closes the same cycle against the
>> RDMA auxiliary probe as the two preceding patches.
>>
>> Use device_trylock() and report the device as busy when it fails, with a
>> distinct message for the same reason as in the previous patch.
>>
>> Fixes: 4b31fd4d77ff ("ice: Fix RDMA VSI removal during queue rebuild")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
>> b/drivers/net/ethernet/intel/ice/ice_main.c
>> index edb62606d2aae3..7b251136149615 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -9448,7 +9448,11 @@ ice_setup_tc(struct net_device *netdev, enum
>> tc_setup_type type,
>>   		cdev = pf->cdev_info;
>>   		if (cdev && cdev->adev) {
>>   			mutex_lock(&pf->adev_mutex);
>> -			device_lock(&cdev->adev->dev);
>> +			if (!device_trylock(&cdev->adev->dev)) {
>> +				mutex_unlock(&pf->adev_mutex);
>> +				netdev_dbg(netdev, "RDMA auxiliary device is
>> busy, try again\n");
>> +				return -EBUSY;
> You return error here, but it looks like being silently dropped in mqprio_disable_offload() isn't it ?

Yes, mqprio_disable_offload() ignores it, the same as it ignores the
existing -EBUSY for a bound RDMA driver. Blocking there brings the
deadlock back and skipping the lock races with the probe, so v2 keeps
the refusal and warns about it instead of netdev_dbg().

> 
>> +			}
>>   			locked = true;
>>   			if (cdev->adev->dev.driver) {
>>   				netdev_err(netdev, "Cannot change qdisc when
>> RDMA is active\n");
>> --
>> 2.56.0
> 

