Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584593;
	b=vJblNGjQZzMOADe4Dwsxkx7WZkt9vp1yePDw/oKRFHmJRVVhnoTaJ0JFyt5vmlDLjAyv
	 NV/FML18ONtjqsd4Mjeak+hFvIVMocNFzSO9j3o88gkq0bx4psimIGUes6Xhhsag3plHw
	 gkpouh6j5D+uB8eNd204IVeR93GJoweDScUuJzb7L15q9kOAXNqIgKGpmHj3zVjxCsS5X
	 dPDoAUcycsCQj6wzUCi6ghUmm4t2e5XiIFAawKnWO4OzlRQ333KtE0edH3EDux7/jb7xk
	 HAjD5uqjQWQ+NgpPuG52c+SGODzFYnUb5RFg+r+OSuPZ/TOuyJe2ja4TmYvx5rNUTxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584593;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	b=sRINIRL/sjN64KpLGkKYZhsAV7JjVJH764JUYEfR8vj34zYel0r1TE/KyalNmM/3AFix
	 U0rPC24wwDUMrKxiCN7+dAbEjopXeLt3y2SqOn7USFNC5A8WPvpfyOqnFPXZ+guOimp/7
	 h1z8JNTsbX8tyUre8ZP2QMIyabMxfuK1AubgoTwAzoQbw2L0ncnbaSZvK+RNF50b1HFvm
	 9iu4NqcLs0OcMbk4I6EwcgYybv0YHpj3hbX6xjvfBRW4MRLnmgIu7/aPKGMuenmpvyecB
	 6yZBshcJrlqESabDmCMdoJ5aAvNPTxDBVkMVLa3lgSe1Bs3me9gS0tQHx/MZp8DXjyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lst.de;
	spf=pass smtp.mailfrom=lst.de;
	arc=none smtp.remote-ip=213.95.11.211
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39AC606A337
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 05:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E39AC606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C928B68AFE; Wed, 25 Nov 2026 06:29:48 +0100 (CET)
Date: Wed, 25 Nov 2026 06:29:48 +0100
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
	syzbot+cd8a9a308e879a4e2c28@syzkaller.appspotmail.com,
	syzbot+ecf51a7ccb6b1394e90c@syzkaller.appspotmail.com,
	syzbot+bc273027d5643e48e5b3@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] jfs: wait for lbmDONE under LCACHE_LOCK in
 lbmRead()
Message-ID: <20261125052948.GB20286@lst.de>
References: <20261123-work-loop-backing-file-v1-0-48f83eaf2499@kernel.org> <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
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
In-Reply-To: <20261123-work-loop-backing-file-v1-1-48f83eaf2499@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

