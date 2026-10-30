Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793398717;
	b=wjqWoSNqf14gEulsmICxzijFiW5D8w1TIXHRd9hLWhiaMcGeUgL9+hV7lkYTaNdJN9ZN
	 K7c4Y2JQnM5qBX3RbVABjHU50H/XSHq+nbOkoRWtvf1999aGOO0VfQDkO9l81kG/Av34s
	 3K3ajUoD9+jBWvJ+PpXOb3k4aShQXckA/xFeJM0qjw1JLE/jA/xkVueHMQRiUsdYo/ZvL
	 8AHD7mWbBoQTH+pIIDa2FW3ELOnZ8/MPLmNQK0ZFnIqFcrbeiixfE+L//r4dcT693ePYs
	 7xHa7GHECyLabiwROf7c/sh68Tbb5yiEdnKqIxKIh0uwM8JEjlsKvnH0kXcSQtwPFqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793398717;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=oduWj+GlQxLwzOkkNtIfxumS7HxJ34KJdwvcCvCC1hQ=;
	b=w13SZJgVql2bklxnl8ghbtpdhoCwi8+6impc3jPqKs5CxduvSUxPQ9hrAJ1FrGgjdT5d
	 wUOyiVZlhh4T8EkbgdSKF1bvD8qF7FhyEvv6IfM6beHPjMQ3ZOgNET/1iq6zPny8ADpsM
	 IWX7V05kGn8Cy1jO/tRcX2Q1yvYV2ww+Dguew/PmQSfsRxviOzoLfZPnZpExRTXBdC2pD
	 SFJsmTow/13oa1LSQhQtQKMDe2a2GEYQ0OKM0asnQ0vyuBvNUg7ps5l1Zmi6A6ymlr4/T
	 +rxdC6d9mzcQJ625wUwtakEOGZelEpmNJraBmrC/hvCPAcOUgASbjfqSXGPvsjzw9Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="XtYV/B1b";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84236606A31A
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 22:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84236606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=XtYV/B1b
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso8071065e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793398715; x=1794003515; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oduWj+GlQxLwzOkkNtIfxumS7HxJ34KJdwvcCvCC1hQ=;
        b=XtYV/B1bxN07KBHMOuXKUJEstWdSm2ywgDOF9aahlPrnK/FunhI8IOUaXv6ttpms5Q
         2/7+7goHpcvKjURvzkbL6A5DbqjO/L4DQ50USlhhQ8ZNUnekJHlPtS78mTelR+JveM7S
         ImoZWkZ1NVHxFtEhta5XOM3xcb05YM0AnZx0N+/Wue8sZvZfOfSXBCQfDq/DqmsgUHZK
         xVOBSQ3B0qLz/9+kEZpgdPPHL6XKjc2l6QpvGm9WWe2v2aSUYAXuw/oCN7OF2lIGaP28
         gAWdnelaA5C1zxBs3OP1O40XDAxFW/7jHBBt5SsAjYv1bPCpDhQrhORbKMaQX+8z/yMz
         ES1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793398715; x=1794003515;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oduWj+GlQxLwzOkkNtIfxumS7HxJ34KJdwvcCvCC1hQ=;
        b=B2lqBG5deQrG40drFHAPxVTwMvJAPDuwa5UASlgzrWJDHBBhFEx7HN0noCFK9GyMaJ
         hqZ+DQ3usW9j04NhaCyeuFO3h0wb5Kz/fCYZf3HtCU6Q3qUxmBlSqwQWHwIStGsII6nM
         IVEuvNDN9zgLtBJP1O+OLFBMvc7VK03DiwJM5XoyC3zyqA7HXjZACdVUHXdmWDerB/+c
         se5TutNoQ80gwFJuVBD5MIH+tCTFlTGoxUJDe31C8S/aggfx5oKLNsz7kiA1+Rs8J0OW
         KK7N067Haog0qCYIT1qaizaRR10i2BxTHTA7fxNT+3yw5U6wncXIPmxdT1FDR3+kC4c9
         5fPw==
X-Forwarded-Encrypted: i=1; AKwUvBxrTe7Eyhk3kpMIFafp9mPA6arqhDxkaEu8BHLz2NCiG5Gpvtncz/CnW8W5VDOXIO2JZo2DONo7+ThwJUYaGQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYL7Rw7BJ8M3EqmXJW5qU6SvweQoY+VKm25l+xsfS6wyEvQVjep3
	6lCIrcYuevCsXN2NPaaUA8IkkAKez4KZ/nAZfCxXNJr3nxsqZyIop0qHTEJ0AG+M1Fo=
X-Gm-Gg: AYBFou1RN9vG3oxJSLo8Yd/70ObOBqdSs2WwjsuhS2fIAyEem/vZmxb6Az09vS91Ruj
	hZvIrR2jQ6zjDfmoVaxsrvSNCQWMo5pM3J1WsD05K3N1vRGmbAh+SukdxpWbubFlXwAoUo+Q3ti
	4FWHcJX1cS2GAkm2NWOqFCTHtHUQBHInGDuWdu6Tno3D0SjlnOQ+y/IUscRDELsEHVTktzqK/Cp
	O0HE8IWzj1gu1PdZWHYgf4hsUzKoPEqMxGEc3IXYm0tAbv8p1fXKk3Y8bpbp3ovZYsIVtcZDNcN
	wIGMUMtiF8fJpdEKLQ2sHTdWek+JHY6OkXFz03EGd3sE7o5IjNUatlkv/woAeNEhefxfrgjBbWC
	61CN5znebWFHOwDmmJBb48XRRbAX8Jis/Z9JuydR4BghYAg79i6eSOa4tpjLBI+sUHmyXjD7qZb
	pZ06Dag5r9+E0k+2k36pKn9BvWppKbFHG8F53LM8r1zIm5CJqPzjfCzkV6GmsheNrTRNmxCObbG
	8qvKKQu0ut47VE6529T5dqwpUpjknb9fgEw/JuOS1mTNRe5cJnqYfEYB0EL3WdM+Xdur/PIRa81
	lzxc4ZV/S53w7EUe9qBrGA==
X-Received: by 2002:a05:600c:4e8c:b0:4a1:dade:f049 with SMTP id 5b1f17b1804b1-4ac1793ff26mr81431795e9.15.1793398714909;
        Fri, 30 Oct 2026 15:18:34 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845fb9f6sm5336668a91.17.2026.10.30.15.18.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 15:18:33 -0700 (PDT)
Message-ID: <56550269-7158-4286-ac12-0509252f5ce2@suse.com>
Date: Sat, 31 Oct 2026 08:48:24 +1030
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
Subject: Re: [PATCH] btrfs: fix a livelock in wait_for_commit() on PREEMPT_RT
To: Daniel Vacek <neelx@suse.com>, linux-btrfs@vger.kernel.org
Cc: "Naulls, Peter" <PeterNaulls@eaton.com>, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org
References: <20261030153617.329733-1-neelx@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <20261030153617.329733-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/31 02:06, Daniel Vacek 写道:
> Peter reported [1] that running multiple RR tasks doing sync()
> on fully preemptible kernel may starve other/normal sync() tasks
> due to fs_info::trans_lock turned into rt_mutex.
> 
> This is caused by RR tasks contending over the mutex with priority over
> other tasks, which in turn lack progress and they are no longer able to
> remove TRANS_STATE_COMPLETED transactions from the fs_info::trans_list.
> 
> The offenders start looping in wait_for_commit() expecting the completed
> transactions to get off the trans_list but since they're bouncing the
> trans_lock the tasks with other/normal priority which are about to delist
> such transactions never get a chance to do so due to lower priority.
> 
> A simple reproducer can be found in the mentioned email thread [1].
> 
> The situation can be resolved by boosting the priority of the starved
> tasks or dropping priority of the offenders. Thought this fix prevents
> the situation from happening in the first place. We simply delist the
> transactions before changing them to completed state. That breaks the
> loop condition.
> 
> [1] https://lore.kernel.org/linux-btrfs/SJ0PR17MB4288C46458DCE2C015839D0FBB9E2@SJ0PR17MB4288.namprd17.prod.outlook.com/
> 
> Reported-by: Naulls, Peter <PeterNaulls@eaton.com>
> Fixes: 5fd76bf31ccfe ("btrfs: fix relocation crash due to premature return from btrfs_commit_transaction()")
> CC: stable@vger.kernel.org # 5.15+
> Tested-by: Naulls, Peter <PeterNaulls@eaton.com>
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c     | 18 +++++++-----------
>   fs/btrfs/transaction.c | 15 +++++----------
>   2 files changed, 12 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index c628c5081d92..6afcd6ca2a8a 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4312,10 +4312,6 @@ static void warn_about_uncommitted_trans(struct btrfs_fs_info *fs_info)
>   			   trans->transid, dirty_bytes);
>   		btrfs_cleanup_one_transaction(trans);
>   
> -		if (trans == fs_info->running_transaction)
> -			fs_info->running_transaction = NULL;
> -		list_del_init(&trans->list);
> -
>   		btrfs_put_transaction(trans);
>   	}
>   	ASSERT(!found);
> @@ -4937,7 +4933,13 @@ void btrfs_cleanup_one_transaction(struct btrfs_transaction *cur_trans)
>   				     EXTENT_DIRTY);
>   	btrfs_destroy_pinned_extent(fs_info, &cur_trans->pinned_extents);
>   
> -	cur_trans->state =TRANS_STATE_COMPLETED;
> +	spin_lock(&fs_info->trans_lock);
> +	if (cur_trans == fs_info->running_transaction)
> +		fs_info->running_transaction = NULL;
> +	list_del_init(&cur_trans->list);
> +	spin_unlock(&fs_info->trans_lock);
> +
> +	cur_trans->state = TRANS_STATE_COMPLETED;
>   	wake_up(&cur_trans->commit_wait);
>   }
>   
> @@ -4973,12 +4975,6 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
>   		}
>   		btrfs_cleanup_one_transaction(t);
>   
> -		spin_lock(&fs_info->trans_lock);
> -		if (t == fs_info->running_transaction)
> -			fs_info->running_transaction = NULL;
> -		list_del_init(&t->list);
> -		spin_unlock(&fs_info->trans_lock);
> -
>   		btrfs_put_transaction(t);
>   		spin_lock(&fs_info->trans_lock);
>   	}
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index d265fac023e5..cd7dff5ba59b 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -2124,12 +2124,7 @@ static void cleanup_transaction(struct btrfs_trans_handle *trans, int err)
>   
>   	spin_unlock(&fs_info->trans_lock);
>   
> -	btrfs_cleanup_one_transaction(trans->transaction);
> -
> -	spin_lock(&fs_info->trans_lock);
> -	if (cur_trans == fs_info->running_transaction)
> -		fs_info->running_transaction = NULL;
> -	spin_unlock(&fs_info->trans_lock);
> +	btrfs_cleanup_one_transaction(cur_trans);
>   
>   	if (trans->type & TRANS_SB_INTWRITER_MASK)
>   		sb_end_intwrite(fs_info->sb);
> @@ -2641,6 +2636,10 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   		btrfs_clear_space_info_full(fs_info);
>   
>   	btrfs_set_last_trans_committed(fs_info, cur_trans->transid);
> +
> +	spin_lock(&fs_info->trans_lock);
> +	list_del_init(&cur_trans->list);
> +	spin_unlock(&fs_info->trans_lock);
>   	/*
>   	 * We needn't acquire the lock here because there is no other task
>   	 * which can change it.
> @@ -2650,10 +2649,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
>   	wake_up(&cur_trans->commit_wait);
>   	btrfs_trans_state_lockdep_release(fs_info, BTRFS_LOCKDEP_TRANS_COMPLETED);
>   
> -	spin_lock(&fs_info->trans_lock);
> -	list_del_init(&cur_trans->list);
> -	spin_unlock(&fs_info->trans_lock);
> -
>   	btrfs_put_transaction(cur_trans);
>   	btrfs_put_transaction(cur_trans);
>   

