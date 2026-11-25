Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584609;
	b=tJxwkx1LGe4nN0xu9bjdGQWCU/fLRLPY65jfj/w2tAyNRln7x4cmetZIUhrZpOlrI5b+
	 Pb5aIbNIQkZBQNLQaG2GJatFd5g/v6Hor29BbZU3dNf5dRL+LnOacpBz88fipiiUF1m5c
	 ZqHA+7ryHfvLIcSwDQSDGlX+1+GO5yvKqlntz5Wzts2qJDObCT5D73IjgMkwBasqkxpCI
	 7Ehc+WGEBsvJdU0enPMVK/DfoNKjd5IOt6d5hbvx79zr2ZRNjVZfGUv608gYv7cSXO7Sp
	 65ZAnKXhbaNgbMX17OKRQPNZxURYYS4XyySQZoCS/tZSHsFoZ/2CNVYFVaRvj4eSD+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584609;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=jy5Q8j6C+ZpkxZh66iu6h1Zf5RITRhndJbJ8kdBrdtG0t0YPN+dCiU+vQ560ziTsO/mI
	 lgAvD42KCaur2kbgBrTBZq7z8YPVRt3f1BGkPx1VcgTdvkSMXEdoKBvJw6dCPrtUQwmka
	 abBVxuf+OA04pRTeUi/eKywDdPVwAcnwavQfbHy2SwEuZ391r6RClre6S0iTH1Kzl/1me
	 VLpTpzfUsvMsquszlDRbumzYVVdGcry3WOJyzVvw7bAW9GRemvzqyIao1DvU5bUNJL8yf
	 WENSAZlk7wZN1rRb2h+fbmUk8xFD/udbH4QEWevSrZ2vFB7OxUmTAwNPG6Hkn99dbnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ACC606A31E
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 05:30:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78ACC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C79E068AFE; Wed, 25 Nov 2026 06:30:05 +0100 (CET)
Date: Wed, 25 Nov 2026 06:30:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Dave Kleikamp <shaggy@kernel.org>,
	jfs-discussion@lists.sourceforge.net,
	Edward Adam Davis <eadavis@qq.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Tao Cui <cui.tao@linux.dev>, Al Viro <viro@zeniv.linux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2e5cf2352e9f69ebf172@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] jfs: set lbmDONE before dropping LCACHE_LOCK for
 lmPostGC()
Message-ID: <20261125053005.GC20286@lst.de>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org> <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-work-loop-backing-file-v1-2-48f83eaf2499@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

