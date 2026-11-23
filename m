Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=199.89.1.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795450760;
	b=4UhK9ZesFMxJiY6hQe+UeQO1kXdbyUc7q2hZBl6NrzoFU0cgJ5UJglIBCFCnY5im/XKt
	 cZPMNETFosoIkbLJYG22rGe9o1kMAFQvVywzI9tikNAMNw5uFFwQSIipam5omzzd0PyG0
	 EA9TuA7DdrBzTFL8MAniIf/CeU3IzRIei8zcKRFSLrjt4+T2Y1wZ36oYGueX3V0RsP8MK
	 iKh5P+xtxsi1MN43B3EosBmZTZ4bkA/bQMEd1cq4PYl6sjsJg2PGdIshiz38Zf/bxFqkp
	 r+98GL8XXkgh8ff4F+/mRu9OaAxaHeDgV4GUfFJ7/zfCyYih+fZUSVQ4oHJpOnnXtEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795450760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Virus-Scanned:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Q8CRVupBHwTiuby1mLW5iiFkt73za/QWEc1/FzrLfs=;
	b=wDGisxl7Ma+EREu5AO/wkEi1xCNYiNwcHtykaNeyxpENX3exqQASNIwxI1F4WI0Ey7kM
	 8qoWjvC7Iodx2p8W9QqyO8FwVLxMuewX4y8Go7XOl5EMhd/8gHS7xcItW96u74nnlEzS+
	 1qqpYgThbZOHsk+fhs+2o9FIK7v1O3QXwQbQV/GuFgRo82sKsO3U07q3YTJqj6yq7a35t
	 OpRpeeY5enGayvq9EPgbk2DfNU4foyQvFObMY3Rh2bk2dplklp6Cpz4GAxf5Sxm45pvSa
	 9ZOEli6Ncxcxxm9YsgrDNFf8I+FjBBhYI2QCzhsblv5UMpOOtEJiiNPgxLnZyL22Zhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=acm.org;
	spf=pass smtp.mailfrom=acm.org;
	dkim=pass header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=h2H7px8x;
	arc=none smtp.remote-ip=199.89.1.16
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6247B606A31F
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 16:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6247B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=acm.org header.i=@acm.org header.a=rsa-sha256 header.s=mr01 header.b=h2H7px8x
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4jYB3B4G69zlgy1M;
	Mon, 23 Nov 2026 16:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1795450754; x=1798042755; bh=6Q8CRVupBHwTiuby1mLW5iiF
	kt73za/QWEc1/FzrLfs=; b=h2H7px8x/P8RWXxbO509o0mZSsR4bG4uJ91t+qCe
	H44nFKYdoLsxfWCUcRKFCdSEPkNMunxp0nPT9VLgc8TuXkQSLW7SrD2xzlDpgxKG
	JR6SDXt3zkDhaSMesJK2K8hrGCrHtDNZiXHzb0U1UgSxrRkd+v1qI9WO/rsI7g5Y
	HGeiw54yxz8qFYNnyuaNhS3RTFisAehAY7w7UhtGjd+tIAyasaf9brtWLgmFu7Qh
	zAm6ETG3NwESpT9nlOfwS+wJYc/Y2oAlISB5S3eoYlwP+pWcOBp/KPb0QDC/euVE
	S3I9ry4oXyjJx9UDD7w8LaUNNEFNaolLXk+M8m0skHQXRA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Z9EzYpVpOFsn; Mon, 23 Nov 2026 16:19:14 +0000 (UTC)
Received: from [100.80.227.185] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4jYB355RHlzljKMg;
	Mon, 23 Nov 2026 16:19:13 +0000 (UTC)
Message-ID: <8895e7f8-8413-4541-aa0b-50c1685b0ea5@acm.org>
Date: Mon, 23 Nov 2026 08:19:11 -0800
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
Subject: Re: [PATCH 2/2] jfs: set lbmDONE before dropping LCACHE_LOCK for
 lmPostGC()
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Dave Kleikamp <shaggy@kernel.org>, jfs-discussion@lists.sourceforge.net,
 Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>,
 Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org,
 stable@vger.kernel.org, syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org>
 <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/26 5:02 AM, Christian Brauner wrote:
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index e96593d79a1df..ae3bd0cd85471 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -2279,9 +2279,11 @@ static void lbmIODone(struct bio *bio)
>   	 *	Group Commit pageout:
>   	 */
>   	else if (bp->l_flag & lbmGC) {
> +		/* lmPostGC() may free or requeue @bp. */
> +		bp->l_flag |= lbmDONE;
>   		LCACHE_UNLOCK(flags);
>   		lmPostGC(bp);
> -		LCACHE_LOCK(flags);		/* disable+lock */
> +		return;
>   	}

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
