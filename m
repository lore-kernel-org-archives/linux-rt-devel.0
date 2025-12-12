Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB692030A
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765501306; cv=none; b=aVOUJwQAo0JI654H8AWIsoSd9hVwiTfg1PJTiKeaRZqOWPaRZdHsAtnLrPahrRP4sdX2vif0HgT8bGpsitxbNag4eFmGOHOte7CFRloomtaiTP8dHJWQfmKXZoTKbIXlgjM5zKTJxmdT8Kd1nt8psMzalmE+RJQepya220OZjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765501306; c=relaxed/simple;
	bh=RvqkoCui2IQB/RgbUMRXZgPo927HN07kQXHCLZ0t/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVSqGh3jkQEL1bdHT1SsjcGgvjeNsRWpIKyObILcBWMTVBcVZZEKF7aZ6YqIwOw/WNC8vrrIr4YmVThyoYIBYleFz/rgziIZHH10dqXHN0G4Io520F7MHcwz21LeKJJsdNRAjndLDU8lH/An7K7ge4LXicImIIWVEXehtVJesHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id D440E72C8CC;
	Fri, 12 Dec 2025 03:54:26 +0300 (MSK)
Received: from pony.office.basealt.ru (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id CCDD536D016E;
	Fri, 12 Dec 2025 03:54:26 +0300 (MSK)
Received: by pony.office.basealt.ru (Postfix, from userid 500)
	id AD8A7360D63C; Fri, 12 Dec 2025 03:54:26 +0300 (MSK)
Date: Fri, 12 Dec 2025 03:54:26 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Ranganath V N <vnranganath.20@gmail.com>, 
	linux-rt-devel@lists.linux.dev
Cc: edumazet@google.com, davem@davemloft.net, david.hunter.linux@gmail.com, 
	horms@kernel.org, jhs@mojatatu.com, jiri@resnulli.us, khalid@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH net v4 2/2] net: sched: act_ife: initialize struct tc_ife
 to fix KMSAN kernel-infoleak
Message-ID: <tnqp5igbbqyl6emzqnei2o4kuz@altlinux.org>
References: <20251109091336.9277-1-vnranganath.20@gmail.com>
 <20251109091336.9277-3-vnranganath.20@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109091336.9277-3-vnranganath.20@gmail.com>

On Sun, Nov 09, 2025 at 02:43:36PM +0530, Ranganath V N wrote:
> Fix a KMSAN kernel-infoleak detected  by the syzbot .
> 
> [net?] KMSAN: kernel-infoleak in __skb_datagram_iter
> 
> In tcf_ife_dump(), the variable 'opt' was partially initialized using a
> designatied initializer. While the padding bytes are reamined
> uninitialized. nla_put() copies the entire structure into a
> netlink message, these uninitialized bytes leaked to userspace.
> 
> Initialize the structure with memset before assigning its fields
> to ensure all members and padding are cleared prior to beign copied.
> 
> This change silences the KMSAN report and prevents potential information
> leaks from the kernel memory.
> 
> This fix has been tested and validated by syzbot. This patch closes the
> bug reported at the following syzkaller link and ensures no infoleak.
> 
> Reported-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=0c85cae3350b7d486aee
> Tested-by: syzbot+0c85cae3350b7d486aee@syzkaller.appspotmail.com
> Fixes: ef6980b6becb ("introduce IFE action")
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
>  net/sched/act_ife.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index 107c6d83dc5c..7c6975632fc2 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -644,13 +644,15 @@ static int tcf_ife_dump(struct sk_buff *skb, struct tc_action *a, int bind,
>  	unsigned char *b = skb_tail_pointer(skb);
>  	struct tcf_ife_info *ife = to_ife(a);
>  	struct tcf_ife_params *p;
> -	struct tc_ife opt = {
> -		.index = ife->tcf_index,
> -		.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> -		.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,
> -	};
> +	struct tc_ife opt;
>  	struct tcf_t t;
>  
> +	memset(&opt, 0, sizeof(opt));
> +
> +	opt.index = ife->tcf_index,
> +	opt.refcnt = refcount_read(&ife->tcf_refcnt) - ref,
> +	opt.bindcnt = atomic_read(&ife->tcf_bindcnt) - bind,

Are you sure this is correct to delimit with commas instead of
semicolons?

This already causes build failures of 5.10.247-rt141 kernel, because
their spin_lock_bh unrolls into do { .. } while (0):

     CC [M]  net/sched/act_ife.o
   In file included from ./include/linux/spinlock.h:329,
                    from ./include/linux/mmzone.h:8,
                    from ./include/linux/gfp.h:6,
                    from ./include/linux/mm.h:10,
                    from ./include/linux/bvec.h:14,
                    from ./include/linux/skbuff.h:17,
                    from net/sched/act_ife.c:20:
   net/sched/act_ife.c: In function 'tcf_ife_dump':
   ./include/linux/spinlock_rt.h:44:2: error: expected expression before 'do'
      44 |  do {     \
         |  ^~
   net/sched/act_ife.c:655:2: note: in expansion of macro 'spin_lock_bh'
     655 |  spin_lock_bh(&ife->tcf_lock);
         |  ^~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:286: net/sched/act_ife.o] Error 1
   make[2]: *** Waiting for unfinished jobs....


Thanks,

> +
>  	spin_lock_bh(&ife->tcf_lock);
>  	opt.action = ife->tcf_action;
>  	p = rcu_dereference_protected(ife->params,
> -- 
> 2.43.0
> 
