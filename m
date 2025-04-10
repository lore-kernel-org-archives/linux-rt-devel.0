Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EBA381A3
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 01:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247855; cv=none; b=mpk8XoMupp9YF4lFhNGKwbuBeYDKqeH9mW4mT6/q0XB7WIciOW1iYmQWkIGvSxFkopWatzxOMcLs6FrRpJbeHv+ZP37wxTQUiRffM8pbOUFfOjI0Llk8xU3145cWFePoofuEO9qODnT+B+6pFZ2jRIGoaXoNH9lbrqeI56fGd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247855; c=relaxed/simple;
	bh=M4iFrckRcXXL+edTeVe0caH6az2Ta8HC+CqJUEd80WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KX/R44r+0x5Fr0Ci66fugnqNGK5RgJ4api608tZxDZULZv4L7Lcih5t6UmFoJ8a3eqU2QV7Lh99ctoSJV0BuYbO9RcnX0leP6QSyFcYAlwxsHY2Ur/lRyi2naZSaEJcpIrauy9xFi2+d9sffu0RV9PVAdEhBuO1e02RSivgHsHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HqKi3Wn/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HqKi3Wn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744247851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7xzS7XLZY2qdrM4JSVF6iQPAbqPC6buSHi7Kkm+Ts/w=;
	b=HqKi3Wn//Y1Pouk/7vhjjCWz2oq7MM/KmzvSnZK1sHxHMLUDODSDSupgHT9srTvArRtxxI
	XUPoSHwiFdxGVM0AAbb8RxN2sDW91UBb8CcdIF5AJjWD7qU/UfKGX8zU3/fYBtOYAZLwqs
	oyM772Z0lnLkljVn5Gn6GLs72q+sVxc=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-ko8Q-JE7P7aRB13SJgYMGA-1; Wed, 09 Apr 2025 21:17:30 -0400
X-MC-Unique: ko8Q-JE7P7aRB13SJgYMGA-1
X-Mimecast-MFC-AGG-ID: ko8Q-JE7P7aRB13SJgYMGA_1744247849
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-224192ff68bso2361525ad.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Apr 2025 18:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744247849; x=1744852649;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xzS7XLZY2qdrM4JSVF6iQPAbqPC6buSHi7Kkm+Ts/w=;
        b=UGUp/eLsYpCqCZ/uci5AEEMGSoDeHGAmNdOV56fNncsrxwFJzzuvKdUj6QJurafbwa
         m9Af3sYiAY9MyTNcS2imK9G3MpfdstIEME7jGALJrWLSvyQpe+H4SCEpA3iV9dnL+dnS
         ntLmh8jJV8kQdHKbAUnkz/68hsHSKuAeKCKq+FK0CJZeT6qstW0919SDr/zhVVacng1j
         brLRT7RHmkr5dmj72JFaGE1PqXvnj12TBUPfe5U/W5FO/4Rp2g59U3Mvc9G57/c+pZWH
         AJ+24PLb5r+Jajt1Eb8lvmT19hojSrKqJZdMc9v4ZWM1dN7Qwvxy6z4xrkNdLsha3s8e
         m7OA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJKTnK49M+CC4gHh8Sy956QJ208L69grkfXNZW769aUJHVMnFdmEtU393LYoGTxxyat2HoAnBGXcabHfGVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0Ud3QggeKP362jQoUv1i9kI10thBG67SeX5jq0XAdULtOxzpS
	GosI2O+Q8V+8v2aXAuXAaXYrnvhfduOlHkHCXWenVhaayCO74o9nY+5ZuINCIlu/ZQy8crRkFrz
	1sz0xTO0IkKnM4Y+xlqawTzCH7qHIKMcBo8RvfZYgs1DCDYLrSCN6wVN2JMw8s3Rb
X-Gm-Gg: ASbGncuSL9yXRk/Rs/4HSLzVfaZOuN8CBV7vfx+rWLbZe4t36TMMwllc1743NN0qTIh
	uXfanQkD81hMV5OfzzCUk2Ilo5xzIZQXWoCYcqIkbzQJBNsB1Alr4+uj7x0YOpZzJQhtNhM6XAj
	JwDewsl+k/mohZTjsetjHC49d3vQtR4M7jw7pPfNdw/Tz7SqyUaqSGHLZCQcvVLgMAyahCZii5A
	7kMcCRvQ7Opch2czpq5bS/KUnaYfikCkqBUt9AWf/ATpYTnTh7/zpZVOOcIVROYoJRFL768F83I
	9HJRq8QjIIfJLRGA7YyX5lFbFUsPOBzRif25aHjvOkR4Vvp0D9gUyC21bcrBNI5V
X-Received: by 2002:a17:902:ce0a:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22b2edcf2a7mr14689775ad.19.1744247849308;
        Wed, 09 Apr 2025 18:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHbv/B25q/BG5rbos8mxYjUX40TLjvJ7m9oY6FlTJ/MEsfzB1q0qTMpChUkwgKeFWkzHCTyQ==
X-Received: by 2002:a17:902:ce0a:b0:224:1d1c:8837 with SMTP id d9443c01a7336-22b2edcf2a7mr14689475ad.19.1744247848844;
        Wed, 09 Apr 2025 18:17:28 -0700 (PDT)
Received: from [192.168.0.229] (159-196-82-144.9fc452.per.static.aussiebb.net. [159.196.82.144])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cafdaasm18861255ad.165.2025.04.09.18.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 18:17:28 -0700 (PDT)
Message-ID: <18e35aab-9cbc-4df0-b88f-34e390a21c8c@redhat.com>
Date: Thu, 10 Apr 2025 09:17:20 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>,
 Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Alexander Larsson <alexl@redhat.com>,
 Lucas Karpinski <lkarpins@redhat.com>
References: <20250408210350.749901-12-echanude@redhat.com>
 <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
From: Ian Kent <ikent@redhat.com>
Autocrypt: addr=ikent@redhat.com; keydata=
 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
In-Reply-To: <20250409-egalisieren-halbbitter-23bc252d3a38@brauner>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dcZMajr9IPCnDV8LzfDVSfxJQL7wSAUhB6UrSukXDd8_1744247849
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/4/25 18:37, Christian Brauner wrote:
> On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
>> Defer releasing the detached file-system when calling namespace_unlock()
>> during a lazy umount to return faster.
>>
>> When requesting MNT_DETACH, the caller does not expect the file-system
>> to be shut down upon returning from the syscall. Calling
>> synchronize_rcu_expedited() has a significant cost on RT kernel that
>> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
>> mount in a separate list and put it on a workqueue to run post RCU
>> grace-period.
>>
>> w/o patch, 6.15-rc1 PREEMPT_RT:
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>>      0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>>      0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
>>
>> w/ patch, 6.15-rc1 PREEMPT_RT:
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>>      0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
>> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>>      0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
>>
>> Signed-off-by: Alexander Larsson <alexl@redhat.com>
>> Signed-off-by: Lucas Karpinski <lkarpins@redhat.com>
>> Signed-off-by: Eric Chanudet <echanude@redhat.com>
>> ---
>>
>> Attempt to re-spin this series based on the feedback received in v3 that
>> pointed out the need to wait the grace-period in namespace_unlock()
>> before calling the deferred mntput().
> I still hate this with a passion because it adds another special-sauce
> path into the unlock path. I've folded the following diff into it so it
> at least doesn't start passing that pointless boolean and doesn't
> introduce __namespace_unlock(). Just use a global variable and pick the
> value off of it just as we do with the lists. Testing this now:

Yeah, it's painful that's for sure.


I also agree with you about the parameter, changing the call signature

always rubbed me the wrong way but I didn't push back on it mostly because

we needed to find a way to do it sensibly and it sounds like that's still

the case.


AFAICT what's needed is a way to synchronize umount with the lockless path

walk. Now umount detaches the mounts concerned, calls the rcu synchronize

(essentially sleeps) to ensure that any lockless path walks see the umount

before completing. But that rcu sync. is, as we can see, really wasteful so

we do need to find a viable way to synchronize this.


Strictly speaking the synchronization problem exists for normal and detached

umounts but if we can find a sound solution for detached mounts perhaps 
we can

extend later (but now that seems like a stretch) ...


I'm not sure why, perhaps it's just me, I don't know, but with this we don't

seem to be working well together to find a solution, I hope we can 
change that

this time around.


I was thinking of using a completion for this synchronization but even that

would be messy because of possible multiple processes doing walks at the 
time

which doesn't lend cleanly to using a completion.


Do you have any ideas on how this could be done yourself?


Ian

>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index e5b0b920dd97..25599428706c 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -82,8 +82,9 @@ static struct hlist_head *mount_hashtable __ro_after_init;
>   static struct hlist_head *mountpoint_hashtable __ro_after_init;
>   static struct kmem_cache *mnt_cache __ro_after_init;
>   static DECLARE_RWSEM(namespace_sem);
> -static HLIST_HEAD(unmounted);  /* protected by namespace_sem */
> -static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
> +static bool unmounted_lazily;          /* protected by namespace_sem */
> +static HLIST_HEAD(unmounted);          /* protected by namespace_sem */
> +static LIST_HEAD(ex_mountpoints);      /* protected by namespace_sem */
>   static DEFINE_SEQLOCK(mnt_ns_tree_lock);
>
>   #ifdef CONFIG_FSNOTIFY
> @@ -1807,17 +1808,18 @@ static void free_mounts(struct hlist_head *mount_list)
>
>   static void defer_free_mounts(struct work_struct *work)
>   {
> -       struct deferred_free_mounts *d = container_of(
> -               to_rcu_work(work), struct deferred_free_mounts, rwork);
> +       struct deferred_free_mounts *d;
>
> +       d = container_of(to_rcu_work(work), struct deferred_free_mounts, rwork);
>          free_mounts(&d->release_list);
>          kfree(d);
>   }
>
> -static void __namespace_unlock(bool lazy)
> +static void namespace_unlock(void)
>   {
>          HLIST_HEAD(head);
>          LIST_HEAD(list);
> +       bool defer = unmounted_lazily;
>
>          hlist_move_list(&unmounted, &head);
>          list_splice_init(&ex_mountpoints, &list);
> @@ -1840,29 +1842,21 @@ static void __namespace_unlock(bool lazy)
>          if (likely(hlist_empty(&head)))
>                  return;
>
> -       if (lazy) {
> -               struct deferred_free_mounts *d =
> -                       kmalloc(sizeof(*d), GFP_KERNEL);
> +       if (defer) {
> +               struct deferred_free_mounts *d;
>
> -               if (unlikely(!d))
> -                       goto out;
> -
> -               hlist_move_list(&head, &d->release_list);
> -               INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> -               queue_rcu_work(system_wq, &d->rwork);
> -               return;
> +               d = kmalloc(sizeof(struct deferred_free_mounts), GFP_KERNEL);
> +               if (d) {
> +                       hlist_move_list(&head, &d->release_list);
> +                       INIT_RCU_WORK(&d->rwork, defer_free_mounts);
> +                       queue_rcu_work(system_wq, &d->rwork);
> +                       return;
> +               }
>          }
> -
> -out:
>          synchronize_rcu_expedited();
>          free_mounts(&head);
>   }
>
> -static inline void namespace_unlock(void)
> -{
> -       __namespace_unlock(false);
> -}
> -
>   static inline void namespace_lock(void)
>   {
>          down_write(&namespace_sem);
> @@ -2094,7 +2088,7 @@ static int do_umount(struct mount *mnt, int flags)
>          }
>   out:
>          unlock_mount_hash();
> -       __namespace_unlock(flags & MNT_DETACH);
> +       namespace_unlock();
>          return retval;
>   }
>
>
>> v4:
>> - Use queue_rcu_work() to defer free_mounts() for lazy umounts
>> - Drop lazy_unlock global and refactor using a helper
>> v3: https://lore.kernel.org/all/20240626201129.272750-2-lkarpins@redhat.com/
>> - Removed unneeded code for lazy umount case.
>> - Don't block within interrupt context.
>> v2: https://lore.kernel.org/all/20240426195429.28547-1-lkarpins@redhat.com/
>> - Only defer releasing umount'ed filesystems for lazy umounts
>> v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/
>>
>>   fs/namespace.c | 52 +++++++++++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 45 insertions(+), 7 deletions(-)
>>
>> diff --git a/fs/namespace.c b/fs/namespace.c
>> index 14935a0500a2..e5b0b920dd97 100644
>> --- a/fs/namespace.c
>> +++ b/fs/namespace.c
>> @@ -45,6 +45,11 @@ static unsigned int m_hash_shift __ro_after_init;
>>   static unsigned int mp_hash_mask __ro_after_init;
>>   static unsigned int mp_hash_shift __ro_after_init;
>>   
>> +struct deferred_free_mounts {
>> +	struct rcu_work rwork;
>> +	struct hlist_head release_list;
>> +};
>> +
>>   static __initdata unsigned long mhash_entries;
>>   static int __init set_mhash_entries(char *str)
>>   {
>> @@ -1789,11 +1794,29 @@ static bool need_notify_mnt_list(void)
>>   }
>>   #endif
>>   
>> -static void namespace_unlock(void)
>> +static void free_mounts(struct hlist_head *mount_list)
>>   {
>> -	struct hlist_head head;
>>   	struct hlist_node *p;
>>   	struct mount *m;
>> +
>> +	hlist_for_each_entry_safe(m, p, mount_list, mnt_umount) {
>> +		hlist_del(&m->mnt_umount);
>> +		mntput(&m->mnt);
>> +	}
>> +}
>> +
>> +static void defer_free_mounts(struct work_struct *work)
>> +{
>> +	struct deferred_free_mounts *d = container_of(
>> +		to_rcu_work(work), struct deferred_free_mounts, rwork);
>> +
>> +	free_mounts(&d->release_list);
>> +	kfree(d);
>> +}
>> +
>> +static void __namespace_unlock(bool lazy)
>> +{
>> +	HLIST_HEAD(head);
>>   	LIST_HEAD(list);
>>   
>>   	hlist_move_list(&unmounted, &head);
>> @@ -1817,12 +1840,27 @@ static void namespace_unlock(void)
>>   	if (likely(hlist_empty(&head)))
>>   		return;
>>   
>> -	synchronize_rcu_expedited();
>> +	if (lazy) {
>> +		struct deferred_free_mounts *d =
>> +			kmalloc(sizeof(*d), GFP_KERNEL);
>>   
>> -	hlist_for_each_entry_safe(m, p, &head, mnt_umount) {
>> -		hlist_del(&m->mnt_umount);
>> -		mntput(&m->mnt);
>> +		if (unlikely(!d))
>> +			goto out;
>> +
>> +		hlist_move_list(&head, &d->release_list);
>> +		INIT_RCU_WORK(&d->rwork, defer_free_mounts);
>> +		queue_rcu_work(system_wq, &d->rwork);
>> +		return;
>>   	}
>> +
>> +out:
>> +	synchronize_rcu_expedited();
>> +	free_mounts(&head);
>> +}
>> +
>> +static inline void namespace_unlock(void)
>> +{
>> +	__namespace_unlock(false);
>>   }
>>   
>>   static inline void namespace_lock(void)
>> @@ -2056,7 +2094,7 @@ static int do_umount(struct mount *mnt, int flags)
>>   	}
>>   out:
>>   	unlock_mount_hash();
>> -	namespace_unlock();
>> +	__namespace_unlock(flags & MNT_DETACH);
>>   	return retval;
>>   }
>>   
>> -- 
>> 2.49.0
>>

